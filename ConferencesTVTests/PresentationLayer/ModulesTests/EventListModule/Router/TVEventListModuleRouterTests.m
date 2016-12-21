//
//  TVEventListModuleTVEventListModuleRouterTests.m
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "TVEventListModuleRouter.h"

@interface TVEventListModuleRouterTests : XCTestCase

@property (nonatomic, strong) TVEventListModuleRouter *router;

@end

@implementation TVEventListModuleRouterTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    self.router = [[TVEventListModuleRouter alloc] init];
}

- (void)tearDown {
    self.router = nil;

    [super tearDown];
}

@end
