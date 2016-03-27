//
//  LectureModuleAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 26/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

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
                              RamblerSelector(dateFormatter)
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
