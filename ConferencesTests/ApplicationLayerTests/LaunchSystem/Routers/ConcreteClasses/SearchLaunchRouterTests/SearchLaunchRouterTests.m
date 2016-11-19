//
//  SearchLaunchRouterTests.m
//  Conferences
//
//  Created by k.zinovyev on 19.11.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "SearchLaunchRouter.h"
#import "TabBarControllerFactory.h"
#import "SearchViewController.h"
#import "SearchViewOutput.h"

@interface SearchLaunchRouterTests : XCTestCase

@property (nonatomic, strong) SearchLaunchRouter *router;
@property (nonatomic, strong) id<TabBarControllerFactory> mockFactory;
@property (nonatomic, strong) UIWindow *mockWindow;

@end

static NSUInteger const kSearchTabIndex = 2;

@implementation SearchLaunchRouterTests

- (void)setUp {
    [super setUp];
    self.mockWindow = [UIWindow new];
    self.mockFactory = OCMProtocolMock(@protocol(TabBarControllerFactory));
    self.router = [[SearchLaunchRouter alloc] initWithTabBarControllerFactory:self.mockFactory
                                                                       window:self.mockWindow];
    
}

- (void)tearDown {
    self.mockWindow = nil;
    self.mockFactory = nil;
    
    self.router = nil;
    
    [super tearDown];
}

- (void)testThatRouterOpenScreenCorrectly {
    //given
    NSString *data = @"data";
    UINavigationController *navigation = [UINavigationController new];
    SearchViewController *searchViewController = [SearchViewController new];
    [navigation setViewControllers:@[searchViewController]];
    id output = OCMProtocolMock(@protocol(SearchViewOutput));
    searchViewController.output = output;
    NSArray *viewControllers = @[
                                 [UIViewController new],
                                 [UIViewController new],
                                 navigation
                                 ];
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    [tabBar setViewControllers:viewControllers];
    OCMStub([self.mockFactory obtainPreconfiguredTabBarController]).andReturn(tabBar);
    
    //when
    [self.router openScreenWithData:data];
    
    //then
    OCMVerify([self.mockFactory updateControllerInTabBarController:tabBar
                                                           atIndex:kSearchTabIndex]);
    XCTAssertEqual(self.mockWindow.rootViewController, tabBar);
    XCTAssertEqual(tabBar.selectedIndex, kSearchTabIndex);
    OCMVerify([searchViewController.output configureSearchModuleWithSearchString:data]);
}

@end
