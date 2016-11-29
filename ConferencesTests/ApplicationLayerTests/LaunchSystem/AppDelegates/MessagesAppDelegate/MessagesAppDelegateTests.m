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

#import "MessagesAppDelegate.h"
#import "LaunchHandler.h"
#import "MessagesUserActivityFactory.h"

static NSString * const SampleStringURL = @"ramblerconferences://report?type=EventModelObject&id=EventModelObject_42";

@interface MessagesAppDelegateTests : XCTestCase

@property (nonatomic, strong) MessagesAppDelegate *appDelegate;
@property (nonatomic, strong) id mockLaunchHandler;
@property (nonatomic, strong) id mockUserActivityFactory;

@end

@implementation MessagesAppDelegateTests

- (void)setUp {
    [super setUp];

    self.mockLaunchHandler = OCMProtocolMock(@protocol(LaunchHandler));
    self.mockUserActivityFactory = OCMClassMock([MessagesUserActivityFactory class]);
    self.appDelegate = [[MessagesAppDelegate alloc] initWithLaunchHandlers:@[self.mockLaunchHandler]
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
    NSURL *url = [NSURL URLWithString:SampleStringURL];
    NSUserActivity *activity = [self generateUserActivityForTestPurposes];
    OCMStub([self.mockUserActivityFactory createUserActivityFromURL:url]).andReturn(activity);

    id mockApplication = [NSObject new];

    OCMStub([self.mockLaunchHandler canHandleLaunchWithActivity:activity]).andReturn(YES);

    // when
    [self.appDelegate application:mockApplication
                          openURL:url
                          options:OCMOCK_ANY];

    // then
    OCMVerify([self.mockLaunchHandler handleLaunchWithActivity:activity]);
}

- (void)testThatAppDelegateDoesNotHandleActivityWithoutCorrespondingLaunchHandler {
    // given
    NSURL *url = [NSURL URLWithString:SampleStringURL];
    NSUserActivity *activity = [self generateUserActivityForTestPurposes];
    OCMStub([self.mockUserActivityFactory createUserActivityFromURL:url]).andReturn(activity);

    id mockApplication = [NSObject new];

    OCMStub([self.mockLaunchHandler canHandleLaunchWithActivity:activity]).andReturn(NO);
    [[self.mockLaunchHandler reject] handleLaunchWithActivity:activity];

    // when
    [self.appDelegate application:mockApplication
                          openURL:url
                          options:OCMOCK_ANY];

    // then
    OCMVerifyAll(self.mockLaunchHandler);
}

#pragma mark - Helper methods

- (NSUserActivity *)generateUserActivityForTestPurposes {
    NSUserActivity *testActivity = [[NSUserActivity alloc] initWithActivityType:@"EventModelObject"];
    return testActivity;
}

@end
