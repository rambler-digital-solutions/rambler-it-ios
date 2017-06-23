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

#import "TabLaunchRouter.h"

#import "TabBarControllerFactory.h"

static NSUInteger kTestTabIndex = 1;

@interface TabLaunchRouterTests : XCTestCase

@property (nonatomic, strong) TabLaunchRouter *router;
@property (nonatomic, strong) id mockTabBarControllerFactory;
@property (nonatomic, strong) id mockWindow;

@property (nonatomic, strong) id mockTabBarController;

@end

@implementation TabLaunchRouterTests

- (void)setUp {
    [super setUp];
    
    self.mockTabBarControllerFactory = OCMProtocolMock(@protocol(TabBarControllerFactory));
    self.mockWindow = OCMClassMock([UIWindow class]);
    
    self.router = [[TabLaunchRouter alloc] initWithTabBarControllerFactory:self.mockTabBarControllerFactory
                                                                    window:self.mockWindow
                                                                  tabIndex:kTestTabIndex];
    
    self.mockTabBarController = OCMClassMock([UITabBarController class]);
}

- (void)tearDown {
    self.router = nil;
    
    self.mockTabBarControllerFactory = nil;
    
    [self.mockWindow stopMocking];
    self.mockWindow = nil;
    
    [self.mockTabBarController stopMocking];
    self.mockTabBarController = nil;
    
    [super tearDown];
}

- (void)testThatRouterOpensDesiredTab {
    // given
    OCMStub([self.mockTabBarControllerFactory obtainPreconfiguredTabBarController]).andReturn(self.mockTabBarController);
    
    // when
    [self.router openScreenWithData:nil];
    
    // then
    OCMVerify([self.mockTabBarController setSelectedIndex:kTestTabIndex]);
}

@end
