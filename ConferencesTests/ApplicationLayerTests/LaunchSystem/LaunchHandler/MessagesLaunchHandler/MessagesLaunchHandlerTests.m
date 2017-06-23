// Copyright (c) 2016 RAMBLER&Co
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
