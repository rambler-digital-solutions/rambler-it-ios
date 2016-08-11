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
#import <UIKit/UIKit.h>
#import <ViperMcFlurry/ViperMcFlurry.h>

#import "EventLaunchRouter.h"

#import "EventModuleInput.h"
#import "TabBarControllerFactory.h"

@interface EventLaunchRouterTests : XCTestCase

@property (nonatomic, strong) EventLaunchRouter *router;
@property (nonatomic, strong) id mockTabBarControllerFactory;
@property (nonatomic, strong) id mockWindow;
@property (nonatomic, strong) id mockStoryboard;

@property (nonatomic, strong) id mockTabBarController;
@property (nonatomic, strong) id mockNavigationController;
@property (nonatomic, strong) id mockTopController;

@end

@implementation EventLaunchRouterTests

- (void)setUp {
    [super setUp];
    
    self.mockTabBarControllerFactory = OCMProtocolMock(@protocol(TabBarControllerFactory));
    self.mockWindow = OCMClassMock([UIWindow class]);
    self.mockStoryboard = OCMClassMock([UIStoryboard class]);
    
    self.router = [[EventLaunchRouter alloc] initWithTabBarControllerFactory:self.mockTabBarControllerFactory
                                                                      window:self.mockWindow
                                                                  storyboard:self.mockStoryboard];
    
    self.mockTabBarController = OCMClassMock([UITabBarController class]);
    self.mockNavigationController = OCMClassMock([UINavigationController class]);
    self.mockTopController = OCMClassMock([UIViewController class]);
    
    OCMStub([self.mockTabBarController selectedViewController]).andReturn(self.mockNavigationController);
    OCMStub([self.mockNavigationController topViewController]).andReturn(self.mockTopController);
}

- (void)tearDown {
    self.router = nil;
    
    self.mockTabBarControllerFactory = nil;
    
    [self.mockWindow stopMocking];
    self.mockWindow = nil;
    
    [self.mockStoryboard stopMocking];
    self.mockStoryboard = nil;
    
    [self.mockTabBarController stopMocking];
    self.mockTabBarController = nil;
    
    [self.mockNavigationController stopMocking];
    self.mockNavigationController = nil;
    
    [self.mockTopController stopMocking];
    self.mockTopController = nil;
    
    [super tearDown];
}

- (void)testThatRouterOpensEventController {
    // given
    OCMStub([self.mockTabBarControllerFactory obtainPreconfiguredTabBarController]).andReturn(self.mockTabBarController);
    
    // when
    [self.router openDataCardScreenWithData:nil];
    
    // then
    OCMVerify([self.mockTopController openModuleUsingFactory:OCMOCK_ANY
                                         withTransitionBlock:OCMOCK_ANY]);
}

- (void)testThatRouterUsesWindowRootViewControllerIfAny {
    // given
    OCMStub([self.mockWindow rootViewController]).andReturn(self.mockTabBarController);
    [[self.mockTabBarControllerFactory reject] obtainPreconfiguredTabBarController];
    
    // when
    [self.router openDataCardScreenWithData:nil];
    
    // then
    OCMVerify([self.mockTopController openModuleUsingFactory:OCMOCK_ANY
                                         withTransitionBlock:OCMOCK_ANY]);
    OCMVerifyAll(self.mockTabBarControllerFactory);
}

@end
