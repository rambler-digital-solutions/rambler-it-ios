//
//  EventListModuleAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 15/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "EventListModuleAssembly_Testable.h"
#import "EventListModuleAssembly.h"

#import "EventListTableViewController.h"
#import "EventListInteractor.h"
#import "EventListPresenter.h"
#import "EventListRouter.h"
#import "EventListDataDisplayManager.h"
#import "ServiceComponentsAssembly.h"
#import "OperationFactoriesAssembly.h"

#import "TabBarButtonPrototype.h"

@interface EventListModuleAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) EventListModuleAssembly *assembly;

@end

@implementation EventListModuleAssemblyTests

- (void)setUp {
    [super setUp];

    self.assembly = [EventListModuleAssembly new];
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
    Class targetClass = [EventListTableViewController class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              RamblerSelector(dataDisplayManager)
                              ];
    // when
    id result = [self.assembly viewEventList];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesInteractor {
    // given
    Class targetClass = [EventListInteractor class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              RamblerSelector(eventService),
                              RamblerSelector(eventPrototypeMapper)
                              ];
    // when
    id result = [self.assembly interactorEventList];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPresenter {
    // given
    Class targetClass = [EventListPresenter class];
    NSArray *dependencies = @[
                              RamblerSelector(view),
                              RamblerSelector(interactor),
                              RamblerSelector(router)
                              ];
    // when
    id result = [self.assembly presenterEventList];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesRouter {
    // given
    Class targetClass = [EventListRouter class  ];
    NSArray *dependencies = @[
                              RamblerSelector(transitionHandler)
                              ];
    // when
    id result = [self.assembly routerEventList];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesDataDisplayManager {
    // given
    Class targetClass = [EventListDataDisplayManager class];

    // when
    id result = [self.assembly dataDisplayManagerEventList];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

- (void)testThatAssemblyCreatesEventListTabBarButtonPrototype {
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
    id result = [self.assembly eventListTabBarButtonPrototype];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

@end
