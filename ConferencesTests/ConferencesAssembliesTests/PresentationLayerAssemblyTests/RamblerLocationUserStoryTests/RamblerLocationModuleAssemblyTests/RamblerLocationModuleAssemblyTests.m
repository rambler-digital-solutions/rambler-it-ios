//
//  RamblerLocationModuleAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 22/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "RamblerLocationModuleAssembly.h"
#import "RamblerLocationModuleAssembly_Testable.h"

#import <RamblerTyphoonUtils/AssemblyCollector.h>
#import "RamblerInitialAssemblyCollector+Activate.h"


#import "RamblerLocationViewController.h"
#import "RamblerLocationInteractor.h"
#import "RamblerLocationPresenter.h"
#import "RamblerLocationRouter.h"
#import "ServiceComponentsAssembly.h"
#import "OperationFactoriesAssembly.h"

@interface RamblerLocationModuleAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) RamblerLocationModuleAssembly *assembly;

@end

@implementation RamblerLocationModuleAssemblyTests

- (void)setUp {
    [super setUp];
    
    Class classAssembly = [RamblerLocationModuleAssembly class];
    self.assembly = [RamblerInitialAssemblyCollector activateAssemblyWithClass:classAssembly];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesView {
    // given
    Class targetClass = [RamblerLocationViewController class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              ];
    // when
    id result = [self.assembly viewRamblerLocation];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesInteractor {
    // given
    Class targetClass = [RamblerLocationInteractor class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              ];
    // when
    id result = [self.assembly interactorRamblerLocation];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPresenter {
    // given
    Class targetClass = [RamblerLocationPresenter class];
    NSArray *dependencies = @[
                              RamblerSelector(view),
                              RamblerSelector(interactor),
                              RamblerSelector(router)
                              ];
    // when
    id result = [self.assembly presenterRamblerLocation];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesRouter {
    // given
    Class targetClass = [RamblerLocationRouter class];
    NSArray *dependencies = @[];
    // when
    id result = [self.assembly routerRamblerLocation];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

@end
