//
//  TVEventListModuleTVEventListModuleAssemblyTests.m
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <RamblerTyphoonUtils/AssemblyTesting.h>
#import <Typhoon/Typhoon.h>

#import "TVEventListModuleAssembly.h"
#import "TVEventListModuleAssembly_Testable.h"

#import "TVEventListModuleViewController.h"
#import "TVEventListModulePresenter.h"
#import "TVEventListModuleInteractor.h"
#import "TVEventListModuleRouter.h"

@interface TVEventListModuleAssemblyTests : RamblerTyphoonAssemblyTests

@property (nonatomic, strong) TVEventListModuleAssembly *assembly;

@end

@implementation TVEventListModuleAssemblyTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.assembly = [[TVEventListModuleAssembly alloc] init];
    [self.assembly activate];
}

- (void)tearDown {
    self.assembly = nil;

    [super tearDown];
}

#pragma mark - Тестирование создания элементов модуля

- (void)testThatAssemblyCreatesViewController {
    // given
    Class targetClass = [TVEventListModuleViewController class];
    NSArray *protocols = @[
                           @protocol(TVEventListModuleViewInput)
                           ];
    NSArray *dependencies = @[
                              RamblerSelector(output)
                              ];

    // when
    id result = [self.assembly viewEventListModuleModule];

    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass
                                                                                                              andProtocols:protocols];
    [self verifyTargetDependency:result
                  withDescriptor:descriptor
                    dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPresenter {
    // given
    Class targetClass = [TVEventListModulePresenter class];
    NSArray *protocols = @[
                           @protocol(TVEventListModuleModuleInput),
                           @protocol(TVEventListModuleViewOutput),
                           @protocol(TVEventListModuleInteractorOutput)
                           ];
    NSArray *dependencies = @[
                              RamblerSelector(interactor),
                              RamblerSelector(view),
                              RamblerSelector(router)
                              ];

    // when
    id result = [self.assembly presenterEventListModuleModule];

    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass
                                                                                                              andProtocols:protocols];
    [self verifyTargetDependency:result
                  withDescriptor:descriptor
                    dependencies:dependencies];
}

- (void)testThatAssemblyCreatesInteractor {
    // given
    Class targetClass = [TVEventListModuleInteractor class];
    NSArray *protocols = @[
                           @protocol(TVEventListModuleInteractorInput)
                           ];
    NSArray *dependencies = @[
                              RamblerSelector(output)
                              ];

    // when
    id result = [self.assembly interactorEventListModuleModule];

    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass
                                                                                                              andProtocols:protocols];
    [self verifyTargetDependency:result
                  withDescriptor:descriptor
                    dependencies:dependencies];
}

- (void)testThatAssemblyCreatesRouter {
    // given
    Class targetClass = [TVEventListModuleRouter class];
    NSArray *protocols = @[
                           @protocol(TVEventListModuleRouterInput)
                           ];
    NSArray *dependencies = @[
                              RamblerSelector(transitionHandler)
                              ];

    // when
    id result = [self.assembly routerEventListModuleModule];

    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass
                                                                                                              andProtocols:protocols];
    [self verifyTargetDependency:result
                  withDescriptor:descriptor
                    dependencies:dependencies];
}

@end
