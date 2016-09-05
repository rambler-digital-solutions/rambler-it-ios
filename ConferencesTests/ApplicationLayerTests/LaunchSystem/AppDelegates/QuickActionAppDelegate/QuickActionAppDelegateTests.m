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

#import "QuickActionAppDelegate.h"
#import "LaunchHandler.h"
#import "QuickActionUserActivityFactory.h"

@interface QuickActionAppDelegateTests : XCTestCase

@property (nonatomic, strong) QuickActionAppDelegate *appDelegate;
@property (nonatomic, strong) id mockLaunchHandler;
@property (nonatomic, strong) id mockUserActivityFactory;

@end

@implementation QuickActionAppDelegateTests

- (void)setUp {
    [super setUp];
    
    self.mockLaunchHandler = OCMProtocolMock(@protocol(LaunchHandler));
    self.mockUserActivityFactory = OCMClassMock([QuickActionUserActivityFactory class]);
    self.appDelegate = [[QuickActionAppDelegate alloc] initWithLaunchHandlers:@[self.mockLaunchHandler]
                                                          userActivityFactory:self.mockUserActivityFactory];
}

- (void)tearDown {
    self.appDelegate = nil;
    self.mockLaunchHandler = nil;
    
    [self.mockUserActivityFactory stopMocking];
    self.mockUserActivityFactory = nil;
    
    [super tearDown];
}

- (void)testThatAppDelegatePassesActivityToCorrespondingLaunchHandler {
    // given
    UIApplicationShortcutItem *item = [self generateShortcutItemForTestPurposes];
    NSUserActivity *activity = [self generateUserActivityForTestPurposes];
    OCMStub([self.mockUserActivityFactory createUserActivityFromShortcutItem:item]).andReturn(activity);
    
    id mockApplication = [NSObject new];
    
    OCMStub([self.mockLaunchHandler canHandleLaunchWithActivity:activity]).andReturn(YES);
    
    // when
    [self.appDelegate application:mockApplication performActionForShortcutItem:item completionHandler:^(BOOL succeeded) {}];
    
    // then
    OCMVerify([self.mockLaunchHandler handleLaunchWithActivity:activity]);
}

- (void)testThatAppDelegateDoesNotHandleActivityWithoutCorrespondingLaunchHandler {
    // given
    UIApplicationShortcutItem *item = [self generateShortcutItemForTestPurposes];
    NSUserActivity *activity = [self generateUserActivityForTestPurposes];
    OCMStub([self.mockUserActivityFactory createUserActivityFromShortcutItem:item]).andReturn(activity);
    
    id mockApplication = [NSObject new];
    
    OCMStub([self.mockLaunchHandler canHandleLaunchWithActivity:activity]).andReturn(NO);
    [[self.mockLaunchHandler reject] handleLaunchWithActivity:activity];
    
    // when
    [self.appDelegate application:mockApplication performActionForShortcutItem:item completionHandler:^(BOOL succeeded) {}];
    
    // then
    OCMVerifyAll(self.mockLaunchHandler);
}

#pragma mark - Helper methods

- (UIApplicationShortcutItem *)generateShortcutItemForTestPurposes {
    UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc] initWithType:@""
                                                                       localizedTitle:@""];;
    return item;
}

- (NSUserActivity *)generateUserActivityForTestPurposes {
    NSUserActivity *testActivity = [[NSUserActivity alloc] initWithActivityType:@"test"];
    return testActivity;
}

@end
