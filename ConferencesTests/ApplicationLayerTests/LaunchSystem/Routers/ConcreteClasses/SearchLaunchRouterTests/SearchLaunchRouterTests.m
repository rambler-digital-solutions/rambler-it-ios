// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "SearchLaunchRouter.h"
#import "TabBarControllerFactory.h"
#import "SearchViewController.h"
#import "SearchViewOutput.h"
#import "SearchModuleInput.h"

@interface SearchLaunchRouterTests : XCTestCase

@property (nonatomic, strong) SearchLaunchRouter *router;
@property (nonatomic, strong) id<TabBarControllerFactory> mockFactory;
@property (nonatomic, strong) UIWindow *mockWindow;

@end

static NSUInteger const kSearchTabIndex = 2;

@implementation SearchLaunchRouterTests

- (void)setUp {
    [super setUp];
    self.mockWindow = OCMClassMock([UIWindow class]);
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
    UITabBarController *tabBar = OCMClassMock([UITabBarController class]);
    UINavigationController *navigation = OCMClassMock([UINavigationController class]);
    id<SearchModuleInput> searchViewController = OCMProtocolMock(@protocol(SearchModuleInput));
    OCMStub(tabBar.selectedViewController).andReturn(navigation);
    OCMStub(navigation.topViewController).andReturn(searchViewController);
    OCMStub([self.mockFactory obtainPreconfiguredTabBarController]).andReturn(tabBar);
    OCMStub(self.mockWindow.rootViewController).andReturn(nil);
    
    //when
    [self.router openScreenWithData:data];
    
    //then
    OCMVerify([self.mockFactory updateControllerInTabBarController:tabBar
                                                           atIndex:kSearchTabIndex]);
    OCMVerify([self.mockWindow setRootViewController:tabBar]);
    OCMVerify([self.mockWindow makeKeyAndVisible]);
    OCMVerify([tabBar setSelectedIndex:kSearchTabIndex]);
    OCMVerify([searchViewController configureSearchModuleWithSearchTerm:data]);
}

@end
