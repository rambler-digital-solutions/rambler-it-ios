//
//  AnnouncementGalleryAnnouncementGalleryViewControllerTests.m
//  RamblerConferences
//
//  Created by Egor Tolstoy on 13/08/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "AnnouncementGalleryViewController.h"

#import "AnnouncementGalleryViewOutput.h"

@interface AnnouncementGalleryViewControllerTests : XCTestCase

@property (nonatomic, strong) AnnouncementGalleryViewController *controller;

@property (nonatomic, strong) id mockOutput;

@end

@implementation AnnouncementGalleryViewControllerTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.controller = [[AnnouncementGalleryViewController alloc] init];

    self.mockOutput = OCMProtocolMock(@protocol(AnnouncementGalleryViewOutput));

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

#pragma mark - Тестирование методов AnnouncementGalleryViewInput

@end
