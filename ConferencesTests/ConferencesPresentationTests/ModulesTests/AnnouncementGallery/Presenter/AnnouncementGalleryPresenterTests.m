//
//  AnnouncementGalleryAnnouncementGalleryPresenterTests.m
//  RamblerConferences
//
//  Created by Egor Tolstoy on 13/08/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "AnnouncementGalleryPresenter.h"

#import "AnnouncementGalleryViewInput.h"
#import "AnnouncementGalleryInteractorInput.h"
#import "AnnouncementGalleryRouterInput.h"

@interface AnnouncementGalleryPresenterTests : XCTestCase

@property (nonatomic, strong) AnnouncementGalleryPresenter *presenter;

@property (nonatomic, strong) id mockInteractor;
@property (nonatomic, strong) id mockRouter;
@property (nonatomic, strong) id mockView;

@end

@implementation AnnouncementGalleryPresenterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.presenter = [[AnnouncementGalleryPresenter alloc] init];

    self.mockInteractor = OCMProtocolMock(@protocol(AnnouncementGalleryInteractorInput));
    self.mockRouter = OCMProtocolMock(@protocol(AnnouncementGalleryRouterInput));
    self.mockView = OCMProtocolMock(@protocol(AnnouncementGalleryViewInput));

    self.presenter.interactor = self.mockInteractor;
    self.presenter.router = self.mockRouter;
    self.presenter.view = self.mockView;
}

- (void)tearDown {
    self.presenter = nil;

    self.mockView = nil;
    self.mockRouter = nil;
    self.mockInteractor = nil;

    [super tearDown];
}

#pragma mark - Тестирование методов AnnouncementGalleryModuleInput

#pragma mark - Тестирование методов AnnouncementGalleryViewOutput

- (void)testThatPresenterHandlesViewReadyEvent {
    // given


    // when
    [self.presenter didTriggerViewReadyEvent];

    // then
    OCMVerify([self.mockView setupInitialState]);
}

#pragma mark - Тестирование методов AnnouncementGalleryInteractorOutput

@end
