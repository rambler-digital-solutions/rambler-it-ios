//
//  EventModuleAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 15/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "EventModuleAssembly.h"
#import "EventModuleAssembly_Testable.h"
#import "EventViewController.h"
#import "EventInteractor.h"
#import "EventPresenter.h"
#import "EventRouter.h"
#import "EventDataDisplayManager.h"
#import "EventPresenterStateStorage.h"
#import "ServiceComponentsAssembly.h"
#import "PresentationLayerHelpersAssembly.h"
#import "EventCellObjectBuilderFactory.h"
#import "OperationFactoriesAssembly.h"

@interface EventModuleAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) EventModuleAssembly *assembly;

@end

@implementation EventModuleAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [EventModuleAssembly new];
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
    Class targetClass = [EventViewController class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              RamblerSelector(dataDisplayManager)
                              ];
    // when
    id result = [self.assembly viewEvent];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesInteractor {
    // given
    Class targetClass = [EventInteractor class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              RamblerSelector(eventService),
                              RamblerSelector(eventPrototypeMapper),
                              RamblerSelector(eventTypeDeterminator)
                              ];
    // when
    id result = [self.assembly interactorEvent];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPresenter {
    // given
    Class targetClass = [EventPresenter class];
    NSArray *dependencies = @[
                              RamblerSelector(view),
                              RamblerSelector(interactor),
                              RamblerSelector(router),
                              RamblerSelector(presenterStateStorage)
                              ];
    // when
    id result = [self.assembly presenterEvent];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesRouter {
    // given
    Class targetClass = [EventRouter class];
    NSArray *dependencies = @[
                              
                              ];
    // when
    id result = [self.assembly routerEvent];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesdataDisplayManager {
    // given
    Class targetClass = [EventDataDisplayManager class];

    // when
    id result = [self.assembly dataDisplayManagerEvent];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

- (void)testThatAssemblyCreatesPresenterStateStorage {
    // given
    Class targetClass = [EventPresenterStateStorage class];

    // when
    id result = [self.assembly presenterStateStorage];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

@end
