//
//  ReportListModuleAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 22/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "ReportListModuleAssembly.h"
#import "ReportListModuleAssembly_Testable.h"
#import "ReportListTableViewController.h"
#import "ReportListInteractor.h"
#import "ReportListPresenter.h"
#import "ReportListRouter.h"
#import "ReportListDataDisplayManager.h"
#import "ServiceComponents.h"
#import "PresentationLayerHelpersAssembly.h"
#import "ServiceComponentsAssembly.h"
#import "OperationFactoriesAssembly.h"

#import "TabBarButtonPrototype.h"

@interface ReportListModuleAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) ReportListModuleAssembly *assembly;

@end

@implementation ReportListModuleAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [ReportListModuleAssembly new];
    [self.assembly activateWithCollaboratingAssemblies:@[
                                                         [ServiceComponentsAssembly new],
                                                         [OperationFactoriesAssembly new]
                                                         ]];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesView {
    // given
    Class targetClass = [ReportListTableViewController class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              RamblerSelector(dataDisplayManager)
                              ];
    // when
    id result = [self.assembly viewReportList];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesInteractor {
    // given
    Class targetClass = [ReportListInteractor class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              RamblerSelector(eventService),
                              RamblerSelector(eventPrototypeMapper),
                              RamblerSelector(eventTypeDeterminator)
                              ];
    // when
    id result = [self.assembly interactorReportList];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPresenter {
    // given
    Class targetClass = [ReportListPresenter class];
    NSArray *dependencies = @[
                              RamblerSelector(view),
                              RamblerSelector(interactor),
                              RamblerSelector(router)
                              ];
    // when
    id result = [self.assembly presenterReportList];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesRouter {
    // given
    Class targetClass = [ReportListRouter class  ];
    NSArray *dependencies = @[
                              RamblerSelector(transitionHandler)
                              ];
    // when
    id result = [self.assembly routerReportList];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesDataDisplayManager {
    // given
    Class targetClass = [ReportListDataDisplayManager class];
    
    // when
    id result = [self.assembly dataDisplayManagerReportList];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

- (void)testThatAssemblyCreatesReportListTabBarButtonPrototype {
    // given
    Class targetClass = [TabBarButtonPrototype class];
    NSArray *dependencies = @[
                              // TODO: разкомментить после добавления изображений
                              
                              //RamblerSelector(tabBarButtonIdleStateImage),
                              //RamblerSelector(tabBarButtonSelectedStateImage),
                              RamblerSelector(tabBarButtonTitle),
                              RamblerSelector(tabbarButtonId),
                              RamblerSelector(tabBarControllercontent)
                              ];
    // when
    id result = [self.assembly reportListTabBarButtonPrototype];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}


@end
