//
//  MessagesLaunchHandlerTests.m
//  Conferences
//
//  Created by Trishina Ekaterina on 14/11/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <CoreSpotlight/CoreSpotlight.h>

#import "MessagesLaunchHandler.h"

#import "ObjectTransformer.h"
#import "LaunchRouter.h"

@interface MessagesLaunchHandlerTests : XCTestCase

@property (nonatomic, strong) MessagesLaunchHandler *launchHandler;
@property (nonatomic, strong) id mockObjectTransformer;
@property (nonatomic, strong) id mockLaunchRouter;

@end

@implementation MessagesLaunchHandlerTests

- (void)setUp {
    [super setUp];

    self.mockObjectTransformer = OCMProtocolMock(@protocol(ObjectTransformer));
    self.mockLaunchRouter = OCMProtocolMock(@protocol(LaunchRouter));

    self.launchHandler = [[MessagesLaunchHandler alloc] initWithObjectTransformer:self.mockObjectTransformer
                                                                     launchRouter:self.mockLaunchRouter];
}

- (void)tearDown {
    self.launchHandler = nil;
    self.mockObjectTransformer = nil;
    self.mockLaunchRouter = nil;
    
    [super tearDown];
}

- (void)testThatHandlerCanHandleProperActivity {
    // given
    NSString *const kTestIdentifier = @"EventModelObject_42";
    NSUserActivity *activity = [self generateUserActivityForTestPurposesWithIdentifier:kTestIdentifier];
    OCMStub([self.mockObjectTransformer isCorrectIdentifier:kTestIdentifier]).andReturn(YES);

    // when
    BOOL result = [self.launchHandler canHandleLaunchWithActivity:activity];

    // then
    XCTAssertTrue(result);
}

- (void)testThatHandlerCanNotHandleForeignActivity {
    // given
    NSString *const kTestIdentifier = @"Event_1234";
    NSUserActivity *activity = [self generateUserActivityForTestPurposesWithIdentifier:kTestIdentifier];
    OCMStub([self.mockObjectTransformer isCorrectIdentifier:kTestIdentifier]).andReturn(NO);

    // when
    BOOL result = [self.launchHandler canHandleLaunchWithActivity:activity];

    // then
    XCTAssertFalse(result);
}

- (void)testThatHandlerHandlesActivityRight {
    // given
    NSString *const kTestIdentifier = @"EventModelObject_42";
    NSUserActivity *activity = [self generateUserActivityForTestPurposesWithIdentifier:kTestIdentifier];

    id mockObject = [NSObject new];
    OCMStub([self.mockObjectTransformer objectForIdentifier:kTestIdentifier]).andReturn(mockObject);

    // when
    [self.launchHandler handleLaunchWithActivity:activity];

    // then
    OCMVerify([self.mockLaunchRouter openScreenWithData:mockObject]);
}

#pragma mark - Helper methods

- (NSUserActivity *)generateUserActivityForTestPurposesWithIdentifier:(NSString *)identifier {
    NSUserActivity *testActivity = [[NSUserActivity alloc] initWithActivityType:@"EventModelObject"];
    testActivity.userInfo = @{
                              CSSearchableItemActivityIdentifier : identifier
                              };
    return testActivity;
}

@end
