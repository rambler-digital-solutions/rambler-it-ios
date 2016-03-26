//
//  SpeakerInfoModuleAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 26/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "SpeakerInfoModuleAssembly_Testable.h"

#import "SpeakerInfoModuleAssembly.h"
#import "ServiceComponentsAssembly.h"
//#import "OperationFactoriesAssembly.h"
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
                                                         //[OperationFactoriesAssembly new],
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
