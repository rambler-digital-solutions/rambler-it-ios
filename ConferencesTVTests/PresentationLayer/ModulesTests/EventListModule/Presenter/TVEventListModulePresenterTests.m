//
//  TVEventListModuleTVEventListModulePresenterTests.m
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "TVEventListModulePresenter.h"

#import "TVEventListModuleViewInput.h"
#import "TVEventListModuleInteractorInput.h"
#import "TVEventListModuleRouterInput.h"

@interface TVEventListModulePresenterTests : XCTestCase

@property (nonatomic, strong) TVEventListModulePresenter *presenter;

@property (nonatomic, strong) id mockInteractor;
@property (nonatomic, strong) id mockRouter;
@property (nonatomic, strong) id mockView;

@end

@implementation TVEventListModulePresenterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.presenter = [[TVEventListModulePresenter alloc] init];

    self.mockInteractor = OCMProtocolMock(@protocol(TVEventListModuleInteractorInput));
    self.mockRouter = OCMProtocolMock(@protocol(TVEventListModuleRouterInput));
    self.mockView = OCMProtocolMock(@protocol(TVEventListModuleViewInput));

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

#pragma mark - Тестирование методов TVEventListModuleModuleInput

#pragma mark - Тестирование методов TVEventListModuleViewOutput

- (void)testThatPresenterHandlesViewReadyEvent {
    // given


    // when
    [self.presenter didTriggerViewReadyEvent];

    // then
    OCMVerify([self.mockView setupInitialState]);
}

#pragma mark - Тестирование методов TVEventListModuleInteractorOutput

@end
