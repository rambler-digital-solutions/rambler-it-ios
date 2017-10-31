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
#import <RamblerTyphoonUtils/AssemblyCollector.h>

#import "RamblerInitialAssemblyCollector+Activate.h"

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
#import "PonsomizerAssembly.h"
#import "ResourceClientAssembly.h"

@interface EventModuleAssemblyTests : RamblerTyphoonAssemblyTests

@property (nonatomic, strong) EventModuleAssembly *assembly;

@end

@implementation EventModuleAssemblyTests

- (void)setUp {
    [super setUp];

    Class class = [EventModuleAssembly class];
    self.assembly = [RamblerInitialAssemblyCollector rds_activateAssemblyWithClass:class];
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
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

- (void)testThatAssemblyCreatesInteractor {
    // given
    Class targetClass = [EventInteractor class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              RamblerSelector(eventService),
                              RamblerSelector(eventTypeDeterminator),
                              RamblerSelector(ponsomizer)
                              ];
    // when
    id result = [self.assembly interactorEvent];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
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
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

- (void)testThatAssemblyCreatesRouter {
    // given
    Class targetClass = [EventRouter class];
    NSArray *dependencies = @[
                              
                              ];
    // when
    id result = [self.assembly routerEvent];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

- (void)testThatAssemblyCreatesdataDisplayManager {
    // given
    Class targetClass = [EventDataDisplayManager class];

    // when
    id result = [self.assembly dataDisplayManagerEvent];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor];
}

- (void)testThatAssemblyCreatesPresenterStateStorage {
    // given
    Class targetClass = [EventPresenterStateStorage class];

    // when
    id result = [self.assembly presenterStateStorage];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor];
}

@end
