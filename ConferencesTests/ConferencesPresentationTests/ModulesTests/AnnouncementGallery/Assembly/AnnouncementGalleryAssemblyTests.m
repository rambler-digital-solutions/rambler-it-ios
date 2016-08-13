//
//  AnnouncementGalleryAnnouncementGalleryAssemblyTests.m
//  RamblerConferences
//
//  Created by Egor Tolstoy on 13/08/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <RamblerTyphoonUtils/AssemblyTesting.h>
#import <Typhoon/Typhoon.h>

#import "AnnouncementGalleryAssembly.h"
#import "AnnouncementGalleryAssembly_Testable.h"

#import "AnnouncementGalleryViewController.h"
#import "AnnouncementGalleryPresenter.h"
#import "AnnouncementGalleryInteractor.h"
#import "AnnouncementGalleryRouter.h"

@interface AnnouncementGalleryAssemblyTests : RamblerTyphoonAssemblyTests

@property (nonatomic, strong) AnnouncementGalleryAssembly *assembly;

@end

@implementation AnnouncementGalleryAssemblyTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.assembly = [[AnnouncementGalleryAssembly alloc] init];
    [self.assembly activate];
}

- (void)tearDown {
    self.assembly = nil;

    [super tearDown];
}

#pragma mark - Тестирование создания элементов модуля

- (void)testThatAssemblyCreatesViewController {
    // given
    Class targetClass = [AnnouncementGalleryViewController class];
    NSArray *protocols = @[
                           @protocol(AnnouncementGalleryViewInput)
                           ];
    NSArray *dependencies = @[
                              RamblerSelector(output)
                              ];

    // when
    id result = [self.assembly viewAnnouncementGalleryModule];

    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass
                                                                                                              andProtocols:protocols];
    [self verifyTargetDependency:result
                  withDescriptor:descriptor
                    dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPresenter {
    // given
    Class targetClass = [AnnouncementGalleryPresenter class];
    NSArray *protocols = @[
                           @protocol(AnnouncementGalleryModuleInput),
                           @protocol(AnnouncementGalleryViewOutput),
                           @protocol(AnnouncementGalleryInteractorOutput)
                           ];
    NSArray *dependencies = @[
                              RamblerSelector(interactor),
                              RamblerSelector(view),
                              RamblerSelector(router)
                              ];

    // when
    id result = [self.assembly presenterAnnouncementGalleryModule];

    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass
                                                                                                              andProtocols:protocols];
    [self verifyTargetDependency:result
                  withDescriptor:descriptor
                    dependencies:dependencies];
}

- (void)testThatAssemblyCreatesInteractor {
    // given
    Class targetClass = [AnnouncementGalleryInteractor class];
    NSArray *protocols = @[
                           @protocol(AnnouncementGalleryInteractorInput)
                           ];
    NSArray *dependencies = @[
                              RamblerSelector(output)
                              ];

    // when
    id result = [self.assembly interactorAnnouncementGalleryModule];

    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass
                                                                                                              andProtocols:protocols];
    [self verifyTargetDependency:result
                  withDescriptor:descriptor
                    dependencies:dependencies];
}

- (void)testThatAssemblyCreatesRouter {
    // given
    Class targetClass = [AnnouncementGalleryRouter class];
    NSArray *protocols = @[
                           @protocol(AnnouncementGalleryRouterInput)
                           ];
    NSArray *dependencies = @[
                              RamblerSelector(transitionHandler)
                              ];

    // when
    id result = [self.assembly routerAnnouncementGalleryModule];

    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass
                                                                                                              andProtocols:protocols];
    [self verifyTargetDependency:result
                  withDescriptor:descriptor
                    dependencies:dependencies];
}

@end
