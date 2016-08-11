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
#import <CoreSpotlight/CoreSpotlight.h>

#import "SpotlightAppDelegate.h"
#import "LaunchHandler.h"

@interface SpotlightAppDelegateTests : XCTestCase

@property (nonatomic, strong) SpotlightAppDelegate *appDelegate;
@property (nonatomic, strong) id mockLaunchHandler;

@end

@implementation SpotlightAppDelegateTests

- (void)setUp {
    [super setUp];
    
    self.mockLaunchHandler = OCMProtocolMock(@protocol(LaunchHandler));
    self.appDelegate = [[SpotlightAppDelegate alloc] initWithLaunchHandlers:@[self.mockLaunchHandler]];
}

- (void)tearDown {
    self.appDelegate = nil;
    self.mockLaunchHandler = nil;
    
    [super tearDown];
}

- (void)testThatAppDelegateDoesNotHandleNotSpotlightActivity {
    // given
    NSUserActivity *testActivity = [self generateUserActivityForTestPurposesWithActivityType:@"123"
                                                                                  identifier:@"123"];
    id mockApplication = [NSObject new];
    
    // when
    BOOL result = [self.appDelegate application:mockApplication
                           continueUserActivity:testActivity
                             restorationHandler:^(NSArray * _Nullable restorableObjects) {}];
    
    // then
    XCTAssertFalse(result);
}

- (void)testThatAppDelegatePassesActivityToCorrespondingLaunchHandler {
    // given
    NSString *const kTestIdentifier = @"Test_Identifier";
    NSUserActivity *testActivity = [self generateUserActivityForTestPurposesWithActivityType:CSSearchableItemActionType
                                                                                  identifier:kTestIdentifier];
    id mockApplication = [NSObject new];
    
    OCMStub([self.mockLaunchHandler canHandleLaunchWithActivity:testActivity]).andReturn(YES);
    
    // when
    BOOL result = [self.appDelegate application:mockApplication
                           continueUserActivity:testActivity
                             restorationHandler:^(NSArray * _Nullable restorableObjects) {}];
    
    // then
    XCTAssertTrue(result);
    OCMVerify([self.mockLaunchHandler handleLaunchWithActivity:testActivity]);
}

- (void)testThatAppDelegateDoesNotHandleActivityWithoutCorrespondingLaunchHandler {
    // given
    NSString *const kTestIdentifier = @"Test_Identifier";
    NSUserActivity *testActivity = [self generateUserActivityForTestPurposesWithActivityType:@"123"
                                                                                  identifier:kTestIdentifier];
    id mockApplication = [NSObject new];
    
    OCMStub([self.mockLaunchHandler canHandleLaunchWithActivity:testActivity]).andReturn(NO);
    [[self.mockLaunchHandler reject] handleLaunchWithActivity:testActivity];
    
    // when
    BOOL result = [self.appDelegate application:mockApplication
                           continueUserActivity:testActivity
                             restorationHandler:^(NSArray * _Nullable restorableObjects) {}];
    
    // then
    XCTAssertFalse(result);
    OCMVerifyAll(self.mockLaunchHandler);
}

#pragma mark - Helper methods

- (NSUserActivity *)generateUserActivityForTestPurposesWithActivityType:(NSString *)activityType
                                                             identifier:(NSString *)identifier {
    NSUserActivity *testActivity = [[NSUserActivity alloc] initWithActivityType:activityType];
    testActivity.userInfo = @{
                              CSSearchableItemActivityIdentifier : identifier
                              };
    return testActivity;
}

@end
