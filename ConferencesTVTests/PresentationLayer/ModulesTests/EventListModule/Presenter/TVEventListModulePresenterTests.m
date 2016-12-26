//
//  TVLectureListModuleTVLectureListModulePresenterTests.m
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "TVLectureListModulePresenter.h"

#import "TVLectureListModuleViewInput.h"
#import "TVLectureListModuleInteractorInput.h"
#import "TVLectureListModuleRouterInput.h"

@interface TVLectureListModulePresenterTests : XCTestCase

@property (nonatomic, strong) TVLectureListModulePresenter *presenter;

@property (nonatomic, strong) id mockInteractor;
@property (nonatomic, strong) id mockRouter;
@property (nonatomic, strong) id mockView;

@end

@implementation TVLectureListModulePresenterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.presenter = [[TVLectureListModulePresenter alloc] init];

    self.mockInteractor = OCMProtocolMock(@protocol(TVLectureListModuleInteractorInput));
    self.mockRouter = OCMProtocolMock(@protocol(TVLectureListModuleRouterInput));
    self.mockView = OCMProtocolMock(@protocol(TVLectureListModuleViewInput));

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

#pragma mark - Тестирование методов TVLectureListModuleModuleInput

#pragma mark - Тестирование методов TVLectureListModuleViewOutput

- (void)testThatPresenterHandlesViewReadyEvent {
    // given


    // when
    [self.presenter didTriggerViewReadyEvent];

    // then
    OCMVerify([self.mockView setupInitialState]);
}

#pragma mark - Тестирование методов TVLectureListModuleInteractorOutput

@end
