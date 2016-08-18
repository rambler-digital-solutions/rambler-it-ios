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

#import "SearchModuleAssembly.h"
#import "ReportListModuleAssembly_Testable.h"
#import "SearchViewController.h"
#import "SearchInteractor.h"
#import "SearchPresenter.h"
#import "SearchRouter.h"
#import "SearchDataDisplayManager.h"
#import "ServiceComponents.h"
#import "PresentationLayerHelpersAssembly.h"
#import "ServiceComponentsAssembly.h"
#import "OperationFactoriesAssembly.h"
#import "PresentationLayerHelpersAssembly.h"
#import "PonsomizerAssembly.h"

@interface ReportListModuleAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) SearchModuleAssembly *assembly;

@end

@implementation ReportListModuleAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [SearchModuleAssembly new];
    [self.assembly activateWithCollaboratingAssemblies:@[
                                                         [ServiceComponentsAssembly new],
                                                         [OperationFactoriesAssembly new],
                                                         [PresentationLayerHelpersAssembly new],
                                                         [PonsomizerAssembly new]
                                                         ]];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesView {
    // given
    Class targetClass = [SearchViewController class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              RamblerSelector(dataDisplayManager)
                              ];
    // when
    id result = [self.assembly viewSearchList];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesInteractor {
    // given
    Class targetClass = [SearchInteractor class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              RamblerSelector(eventService),
                              RamblerSelector(ponsomizer),
                              RamblerSelector(eventTypeDeterminator)
                              ];
    // when
    id result = [self.assembly interactorSearchList];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPresenter {
    // given
    Class targetClass = [SearchPresenter class];
    NSArray *dependencies = @[
                              RamblerSelector(view),
                              RamblerSelector(interactor),
                              RamblerSelector(router)
                              ];
    // when
    id result = [self.assembly presenterSearchList];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesRouter {
    // given
    Class targetClass = [SearchRouter class  ];
    NSArray *dependencies = @[
                              RamblerSelector(transitionHandler)
                              ];
    // when
    id result = [self.assembly routerSearchList];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesDataDisplayManager {
    // given
    Class targetClass = [SearchDataDisplayManager class];
    NSArray *dependencies = @[
                              RamblerSelector(dateFormatter)
                              ];
    
    // when
    id result = [self.assembly dataDisplayManagerSearchList];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

@end
