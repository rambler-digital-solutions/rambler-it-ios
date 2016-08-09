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

#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "SpeakerInfoModuleAssembly_Testable.h"

#import "SpeakerInfoModuleAssembly.h"
#import "ServiceComponentsAssembly.h"
#import "PresentationLayerHelpersAssembly.h"

#import "SpeakerInfoViewController.h"
#import "SpeakerInfoInteractor.h"
#import "SpeakerInfoPresenter.h"
#import "SpeakerInfoRouter.h"
#import "SpeakerInfoPresenterStateStorage.h"
#import "SpeakerInfoDataDisplayManager.h"

@interface SpeakerInfoModuleAssemblyTests : RamblerTyphoonAssemblyTests

@property (nonatomic, strong) SpeakerInfoModuleAssembly *assembly;

@end

@implementation SpeakerInfoModuleAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [SpeakerInfoModuleAssembly new];
    [self.assembly activateWithCollaboratingAssemblies:@[[ServiceComponentsAssembly new],
                                                         [PresentationLayerHelpersAssembly new]]];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesView {
    // given
    Class targetClass = [SpeakerInfoViewController class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              RamblerSelector(dataDisplayManager)
                              ];
    // when
    id result = [self.assembly viewSpeakerInfo];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesInteractor {
    // given
    Class targetClass = [SpeakerInfoInteractor class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              ];
    // when
    id result = [self.assembly interactorSpeakerInfo];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPresenter {
    // given
    Class targetClass = [SpeakerInfoPresenter class];
    NSArray *dependencies = @[
                              RamblerSelector(view),
                              RamblerSelector(interactor),
                              RamblerSelector(router),
                              RamblerSelector(stateStorage)
                              ];
    // when
    id result = [self.assembly presenterSpeakerInfo];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesRouter {
    // given
    Class targetClass = [SpeakerInfoRouter class  ];
    NSArray *dependencies = @[
                              ];
    // when
    id result = [self.assembly routerSpeakerInfo];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesDataDisplayManager {
    // given
    Class targetClass = [SpeakerInfoDataDisplayManager class];
    NSArray *dependencies = @[
                              ];
    // when
    id result = [self.assembly dataDisplayManagerSpeakerInfo];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPresenterStateStorage {
    // given
    Class targetClass = [SpeakerInfoPresenterStateStorage class];
    
    // when
    id result = [self.assembly presenterStateStorageSpeakerInfo];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

@end
