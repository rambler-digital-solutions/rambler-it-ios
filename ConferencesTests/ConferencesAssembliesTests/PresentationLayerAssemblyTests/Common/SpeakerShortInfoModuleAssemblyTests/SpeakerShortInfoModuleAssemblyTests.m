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

#import "SpeakerShortInfoModuleAssembly_Testable.h"

#import "SpeakerShortInfoModuleAssembly.h"
#import "SpeakerShortInfoView.h"
#import "SpeakerShortInfoInteractor.h"
#import "SpeakerShortInfoPresenter.h"
#import "SpeakerShortInfoRouter.h"
#import "PresentationLayerHelpersAssembly.h"
#import "ServiceComponentsAssembly.h"
#import "OperationFactoriesAssembly.h"

@interface SpeakerShortInfoModuleAssemblyTests : RamblerTyphoonAssemblyTests

@property (nonatomic, strong) SpeakerShortInfoModuleAssembly *assembly;

@end

@implementation SpeakerShortInfoModuleAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [SpeakerShortInfoModuleAssembly new];
    [self.assembly activateWithCollaboratingAssemblies:@[[ServiceComponentsAssembly new],
                                                         [OperationFactoriesAssembly new],
                                                         [PresentationLayerHelpersAssembly new]]];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesView {
    // given
    Class targetClass = [SpeakerShortInfoView class];
    NSArray *dependencies = @[
                              RamblerSelector(output)
                              ];
    // when
    id result = [self.assembly viewSpeakerShortInfo];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

- (void)testThatAssemblyCreatesInteractor {
    // given
    Class targetClass = [SpeakerShortInfoInteractor class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              ];
    // when
    id result = [self.assembly interactorSpeakerShortInfo];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPresenter {
    // given
    Class targetClass = [SpeakerShortInfoPresenter class];
    NSArray *dependencies = @[
                              RamblerSelector(view),
                              RamblerSelector(interactor),
                              RamblerSelector(router),
                              ];
    // when
    id result = [self.assembly presenterSpeakerShortInfo];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

- (void)testThatAssemblyCreatesRouter {
    // given
    Class targetClass = [SpeakerShortInfoRouter class];
    NSArray *dependencies = @[
                              ];
    // when
    id result = [self.assembly routerSpeakerShortInfo];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

@end
