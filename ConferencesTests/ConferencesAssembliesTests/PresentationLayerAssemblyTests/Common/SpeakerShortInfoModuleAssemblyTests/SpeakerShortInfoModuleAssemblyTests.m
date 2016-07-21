//
//  SpeakerShortInfoModuleAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 26/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

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
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
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
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
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
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesRouter {
    // given
    Class targetClass = [SpeakerShortInfoRouter class];
    NSArray *dependencies = @[
                              ];
    // when
    id result = [self.assembly routerSpeakerShortInfo];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

@end
