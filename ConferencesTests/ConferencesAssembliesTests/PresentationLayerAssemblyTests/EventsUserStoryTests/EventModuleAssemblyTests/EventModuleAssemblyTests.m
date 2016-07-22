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
#import "CoreAssembly.h"

@interface EventModuleAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) EventModuleAssembly *assembly;

@end

@implementation EventModuleAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [EventModuleAssembly new];
    [self.assembly activateWithCollaboratingAssemblies:@[
                                                         [ServiceComponentsAssembly new],
                                                         [OperationFactoriesAssembly new],
                                                         [CoreAssembly new]
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
