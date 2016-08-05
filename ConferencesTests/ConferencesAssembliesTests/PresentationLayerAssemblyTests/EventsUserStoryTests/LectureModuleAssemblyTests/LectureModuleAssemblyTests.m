// Copyright (c) 2016 RAMBLER&Co
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

#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "LectureModuleAssembly_Testable.h"

#import "LectureModuleAssembly.h"
#import "LectureViewController.h"
#import "LectureInteractor.h"
#import "LecturePresenter.h"
#import "LectureRouter.h"
#import "LectureDataDisplayManager.h"
#import "LecturePresenterStateStorage.h"
#import "PresentationLayerHelpersAssembly.h"
#import "ServiceComponentsAssembly.h"

@interface LectureModuleAssemblyTests : RamblerTyphoonAssemblyTests

@property (nonatomic, strong) LectureModuleAssembly *assembly;

@end

@implementation LectureModuleAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [LectureModuleAssembly new];
    [self.assembly activateWithCollaboratingAssemblies:@[[ServiceComponentsAssembly new],
                                                         [PresentationLayerHelpersAssembly new]]];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesView {
    // given
    Class targetClass = [LectureViewController class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              RamblerSelector(dataDisplayManager)
                              ];
    // when
    id result = [self.assembly viewLecture];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesInteractor {
    // given
    Class targetClass = [LectureInteractor class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              RamblerSelector(ponsomizer),
                              RamblerSelector(lectureService)
                              ];
    // when
    id result = [self.assembly interactorLecture];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPresenter {
    // given
    Class targetClass = [LecturePresenter class];
    NSArray *dependencies = @[
                              RamblerSelector(view),
                              RamblerSelector(interactor),
                              RamblerSelector(router),
                              RamblerSelector(stateStorage)
                              ];
    // when
    id result = [self.assembly presenterLecture];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesRouter {
    // given
    Class targetClass = [LectureRouter class];
    NSArray *dependencies = @[
                              RamblerSelector(transitionHandler)
                              ];
    // when
    id result = [self.assembly routerLecture];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesDataDisplayManager {
    // given
    Class targetClass = [LectureDataDisplayManager class];
    NSArray *dependencies = @[
                              RamblerSelector(builderCellObjects)
                              ];
    // when
    id result = [self.assembly dataDisplayManagerLecture];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPresenterStateStorage {
    // given
    Class targetClass = [LecturePresenterStateStorage class];
    
    // when
    id result = [self.assembly presenterStateStorageLecture];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

@end
