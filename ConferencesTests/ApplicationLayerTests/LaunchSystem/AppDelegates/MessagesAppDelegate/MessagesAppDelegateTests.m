//
//  MessagesAppDelegateTests.m
//  Conferences
//
//  Created by Trishina Ekaterina on 14/11/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <UIKit/UIKit.h>

#import "MessagesAppDelegate.h"
#import "LaunchHandler.h"
#import "MessagesUserActivityFactory.h"

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
    NSString *stringURL = @"ramblerconferences://report?type=EventModelObject&id=EventModelObject_42";
    NSURL *url = [NSURL URLWithString:stringURL];
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
    NSString *stringURL = @"ramblerconferences://report?type=EventModelObject&id=EventModelObject_42";
    NSURL *url = [NSURL URLWithString:stringURL];
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
