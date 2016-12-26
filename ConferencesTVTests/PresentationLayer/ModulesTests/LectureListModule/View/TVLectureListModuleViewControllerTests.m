//
//  TVLectureListModuleTVLectureListModuleViewControllerTests.m
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "TVLectureListModuleViewController.h"

#import "TVLectureListModuleViewOutput.h"

@interface TVLectureListModuleViewControllerTests : XCTestCase

@property (nonatomic, strong) TVLectureListModuleViewController *controller;

@property (nonatomic, strong) id mockOutput;

@end

@implementation TVLectureListModuleViewControllerTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.controller = [[TVLectureListModuleViewController alloc] init];

    self.mockOutput = OCMProtocolMock(@protocol(TVLectureListModuleViewOutput));

    self.controller.output = self.mockOutput;
}

- (void)tearDown {
    self.controller = nil;

    self.mockOutput = nil;

    [super tearDown];
}

#pragma mark - Тестирование жизненного цикла

- (void)testThatControllerNotifiesPresenterOnDidLoad {
	// given

	// when
	[self.controller viewDidLoad];

	// then
	OCMVerify([self.mockOutput didTriggerViewReadyEvent]);
}

#pragma mark - Тестирование методов интерфейса

#pragma mark - Тестирование методов TVLectureListModuleViewInput

@end
