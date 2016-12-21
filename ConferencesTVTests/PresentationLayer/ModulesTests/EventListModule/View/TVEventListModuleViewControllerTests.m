//
//  TVEventListModuleTVEventListModuleViewControllerTests.m
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "TVEventListModuleViewController.h"

#import "TVEventListModuleViewOutput.h"

@interface TVEventListModuleViewControllerTests : XCTestCase

@property (nonatomic, strong) TVEventListModuleViewController *controller;

@property (nonatomic, strong) id mockOutput;

@end

@implementation TVEventListModuleViewControllerTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.controller = [[TVEventListModuleViewController alloc] init];

    self.mockOutput = OCMProtocolMock(@protocol(TVEventListModuleViewOutput));

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

#pragma mark - Тестирование методов TVEventListModuleViewInput

@end
