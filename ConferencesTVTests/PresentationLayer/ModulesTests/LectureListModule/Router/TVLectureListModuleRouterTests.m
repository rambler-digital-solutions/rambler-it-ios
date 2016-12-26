//
//  TVLectureListModuleTVLectureListModuleRouterTests.m
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "TVLectureListModuleRouter.h"

@interface TVLectureListModuleRouterTests : XCTestCase

@property (nonatomic, strong) TVLectureListModuleRouter *router;

@end

@implementation TVLectureListModuleRouterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.router = [[TVLectureListModuleRouter alloc] init];
}

- (void)tearDown {
    self.router = nil;

    [super tearDown];
}

@end
