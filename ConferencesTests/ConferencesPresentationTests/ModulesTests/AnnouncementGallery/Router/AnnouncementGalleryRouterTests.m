//
//  AnnouncementGalleryAnnouncementGalleryRouterTests.m
//  RamblerConferences
//
//  Created by Egor Tolstoy on 13/08/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "AnnouncementGalleryRouter.h"

@interface AnnouncementGalleryRouterTests : XCTestCase

@property (nonatomic, strong) AnnouncementGalleryRouter *router;

@end

@implementation AnnouncementGalleryRouterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.router = [[AnnouncementGalleryRouter alloc] init];
}

- (void)tearDown {
    self.router = nil;

    [super tearDown];
}

@end
