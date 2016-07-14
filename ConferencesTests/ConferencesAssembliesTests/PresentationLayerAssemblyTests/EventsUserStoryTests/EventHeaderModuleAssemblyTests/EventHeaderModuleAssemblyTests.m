//
//  EventHeaderModuleAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 26/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "EventHeaderModuleAssembly.h"
#import "EventHeaderModuleAssembly_Testable.h"
#import "RamblerInitialAssemblyCollector+Activate.h"

#import "EventHeaderView.h"
#import "EventHeaderInteractor.h"
#import "EventHeaderPresenter.h"
#import "EventHeaderRouter.h"

#import "PresentationLayerHelpersAssembly.h"
#import "ServiceComponentsAssembly.h"

@interface EventHeaderModuleAssemblyTests : RamblerTyphoonAssemblyTests

@property (nonatomic, strong) EventHeaderModuleAssembly *assembly;

@end

@implementation EventHeaderModuleAssemblyTests

- (void)setUp {
    [super setUp];
    
    Class classAssembly = [EventHeaderModuleAssembly class];
    self.assembly = [RamblerInitialAssemblyCollector activateAssemblyWithClass:classAssembly];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesView {
    // given
    Class targetClass = [EventHeaderView class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              RamblerSelector(eventHeaderView)
                              ];
    // when
    id result = [self.assembly viewEventHeader];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesInteractor {
    // given
    Class targetClass = [EventHeaderInteractor class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              ];
    // when
    id result = [self.assembly interactorEventHeader];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPresenter {
    // given
    Class targetClass = [EventHeaderPresenter class];
    NSArray *dependencies = @[
                              RamblerSelector(view),
                              RamblerSelector(interactor),
                              RamblerSelector(router),
                              ];
    // when
    id result = [self.assembly presenterEventHeader];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesRouter {
    // given
    Class targetClass = [EventHeaderRouter class];
    NSArray *dependencies = @[
                              ];
    // when
    id result = [self.assembly routerEventHeader];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

@end
