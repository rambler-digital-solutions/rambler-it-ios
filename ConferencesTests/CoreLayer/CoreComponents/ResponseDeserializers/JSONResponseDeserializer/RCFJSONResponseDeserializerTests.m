//
//  RCFJSONResponseDeserializerTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "XCTestCase+RCFHelpers.h"
#import "TestConstants.h"

#import "RCFJSONResponseDeserializer.h"

@interface RCFJSONResponseDeserializerTests : XCTestCase

@property (strong, nonatomic) RCFJSONResponseDeserializer *deserializer;

@end

@implementation RCFJSONResponseDeserializerTests

- (void)setUp {
    [super setUp];
    
    self.deserializer = [[RCFJSONResponseDeserializer alloc] init];
}

- (void)tearDown {
    self.deserializer = nil;
    
    [super tearDown];
}

- (void)testThatDeserializerDeserializeSimpleJSON {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    NSData *data = [self generateJSONResponseData];
    __block NSDictionary *result;
    
    // when
    [self.deserializer deserializeServerResponse:data
                                 completionBlock:^(NSDictionary *response, NSError *error) {
        result = response;
        [self fulfillExpectationInMainThread:expectation];
    }];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout
                                 handler:^(NSError *error) {
        XCTAssertNotNil(result);
        XCTAssertEqualObjects([[result allKeys] firstObject], @"key");
        XCTAssertEqualObjects([[result allValues] firstObject], @"value");
    }];
}

#pragma mark - Helper Methods

- (NSData *)generateJSONResponseData {
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{
                                                             @"key" : @"value"
                                                             }
                                                   options:0
                                                     error:nil];
    return data;
}

@end
