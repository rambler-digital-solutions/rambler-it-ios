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

#import "QuickActionLaunchHandler.h"

#import "ObjectTransformer.h"
#import "LaunchRouter.h"
#import "QuickActionConstants.h"

static NSString *const kTestType = @"1234abcd";

@interface QuickActionLaunchHandlerTests : XCTestCase

@property (nonatomic, strong) QuickActionLaunchHandler *launchHandler;
@property (nonatomic, strong) id mockObjectTransformer;
@property (nonatomic, strong) id mockLaunchRouter;

@end

@implementation QuickActionLaunchHandlerTests

- (void)setUp {
    [super setUp];
    
    self.mockObjectTransformer = OCMProtocolMock(@protocol(ObjectTransformer));
    self.mockLaunchRouter = OCMProtocolMock(@protocol(LaunchRouter));
    
    self.launchHandler = [[QuickActionLaunchHandler alloc] initWithObjectTransformer:self.mockObjectTransformer
                                                                        launchRouter:self.mockLaunchRouter
                                                                 quickActionItemType:kTestType];
}

- (void)tearDown {
    self.launchHandler = nil;
    self.mockObjectTransformer = nil;
    self.mockLaunchRouter = nil;
    
    [super tearDown];
}

- (void)testThatHandlerCanHandleActivityWithType {
    // given
    NSUserActivity *activity = [self generateUserActivityForTestPurposesWithType:kTestType
                                                                      identifier:nil];
    
    // when
    BOOL result = [self.launchHandler canHandleLaunchWithActivity:activity];
    
    // then
    XCTAssertTrue(result);
}

- (void)testThatHandlerCanHandleActivityWithIdentifier {
    // given
    NSString *const kTestIdentifier = @"1234";
    OCMStub([self.mockObjectTransformer isCorrectIdentifier:kTestIdentifier]).andReturn(YES);
    NSUserActivity *activity = [self generateUserActivityForTestPurposesWithType:kTestType
                                                                      identifier:kTestIdentifier];
    
    // when
    BOOL result = [self.launchHandler canHandleLaunchWithActivity:activity];
    
    // then
    XCTAssertTrue(result);
}

- (void)testThatHandlerCanNotHandleActivityWithWrongType {
    // given
    NSUserActivity *activity = [self generateUserActivityForTestPurposesWithType:@"0"
                                                                      identifier:nil];
    
    // when
    BOOL result = [self.launchHandler canHandleLaunchWithActivity:activity];
    
    // then
    XCTAssertFalse(result);
}

- (void)testThatHandlerCanNotHandleActivityWithWrongIdentifier {
    // given
    NSString *const kTestIdentifier = @"1234";
    OCMStub([self.mockObjectTransformer isCorrectIdentifier:kTestIdentifier]).andReturn(NO);
    NSUserActivity *activity = [self generateUserActivityForTestPurposesWithType:kTestType
                                                                      identifier:kTestIdentifier];
    
    // when
    BOOL result = [self.launchHandler canHandleLaunchWithActivity:activity];
    
    // then
    XCTAssertFalse(result);
}

- (void)testThatHandlerHandlesActivityWithType {
    // given
    NSUserActivity *activity = [self generateUserActivityForTestPurposesWithType:kTestType
                                                                      identifier:nil];
    
    // when
    [self.launchHandler handleLaunchWithActivity:activity];
    
    // then
    OCMVerify([self.mockLaunchRouter openScreenWithData:nil]);
}

- (void)testThatHandlerHandlesActivityWithIdentifier {
    // given
    NSString *const kTestIdentifier = @"1234";
    id mockData = [NSObject new];
    OCMStub([self.mockObjectTransformer objectForIdentifier:kTestIdentifier]).andReturn(mockData);
    NSUserActivity *activity = [self generateUserActivityForTestPurposesWithType:kTestType
                                                                      identifier:kTestIdentifier];
    
    // when
    [self.launchHandler handleLaunchWithActivity:activity];
    
    // then
    OCMVerify([self.mockLaunchRouter openScreenWithData:mockData]);
}

#pragma mark - Helper methods

- (NSUserActivity *)generateUserActivityForTestPurposesWithType:(NSString *)type
                                                           identifier:(NSString *)identifier {
    NSUserActivity *testActivity = [[NSUserActivity alloc] initWithActivityType:type];
    if (identifier) {
        testActivity.userInfo = @{
                                  kQuickActionItemIdentifierKey : identifier
                                  };
    }
    
    return testActivity;
}

@end
