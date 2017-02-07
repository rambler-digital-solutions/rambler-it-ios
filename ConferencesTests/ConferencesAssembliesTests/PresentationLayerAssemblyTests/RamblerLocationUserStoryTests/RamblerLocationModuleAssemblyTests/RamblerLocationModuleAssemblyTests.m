// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
#import "RamblerLocationFeedbackGeneratorImplementation.h"

#import "UberRidesFactory.h"

@interface RamblerLocationModuleAssemblyTests : RamblerTyphoonAssemblyTests

@property (nonatomic, strong) RamblerLocationModuleAssembly *assembly;

@end

@implementation RamblerLocationModuleAssemblyTests

- (void)setUp {
    [super setUp];
    
    Class classAssembly = [RamblerLocationModuleAssembly class];
    self.assembly = [RamblerInitialAssemblyCollector rds_activateAssemblyWithClass:classAssembly];
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
                              RamblerSelector(dataDisplayManager),
                              RamblerSelector(requestBehavior),
                              RamblerSelector(uberRidesFactory),
                              RamblerSelector(feedbackGenerator)
                              ];
    // when
    id result = [self.assembly viewRamblerLocation];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

- (void)testThatAssemblyCreatesInteractor {
    // given
    Class targetClass = [RamblerLocationInteractor class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              RamblerSelector(ramblerLocationService),
                              RamblerSelector(mapLinkBuilder),
                              RamblerSelector(builder),
                              RamblerSelector(locationService),
                              RamblerSelector(ridesClient),
                              ];
    // when
    id result = [self.assembly interactorRamblerLocation];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
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
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

- (void)testThatAssemblyCreatesRouter {
    // given
    Class targetClass = [RamblerLocationRouter class];
    NSArray *dependencies = @[];
    // when
    id result = [self.assembly routerRamblerLocation];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

- (void)testThatAssemblyCreatesUberRidesFactory {
    // given
    Class targetClass = [UberRidesFactory class];
    NSArray *dependencies = @[];
    
    // when
    id result = [self.assembly uberRidesFactory];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

- (void)testThatAssemblyCreatesFeebackGenerator {
    // given
    Class targetClass = [RamblerLocationFeedbackGeneratorImplementation class];
    NSArray *dependencies = @[
                              RamblerSelector(feedbackGenerator) ];
    // when
    id result = [self.assembly feedbackGeneratorRamblerLocation];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

@end
