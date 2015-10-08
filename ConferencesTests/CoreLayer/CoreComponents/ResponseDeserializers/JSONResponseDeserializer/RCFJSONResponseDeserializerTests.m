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

- (void)testThatDeserializerDeserializeValidJSON {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    NSData *data = [self generateValidJSONResponseData];
    __block NSError *resultError;
    __block NSDictionary *resultDictionary;
    
    // when
    [self.deserializer deserializeServerResponse:data
                                 completionBlock:^(NSDictionary *response, NSError *error) {
                                     resultError =  error;
                                     resultDictionary = response;
                                     [self fulfillExpectationInMainThread:expectation];
    }];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout
                                 handler:^(NSError *error) {
        XCTAssertNotNil(resultDictionary);
        XCTAssertNil(resultError);
        XCTAssertEqualObjects([[resultDictionary allKeys] firstObject], @"key");
        XCTAssertEqualObjects([[resultDictionary allValues] firstObject], @"value");
    }];
}

- (void)testThatDeserializerFailsWithInvalidData {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    NSData *data = [self generateInvalidJSONResponseData];
    __block NSError *resultError;
    __block NSDictionary *resultDictionary;
    
    // when
    [self.deserializer deserializeServerResponse:data
                                 completionBlock:^(NSDictionary *response, NSError *error) {
                                     resultError =  error;
                                     resultDictionary = response;
                                     [self fulfillExpectationInMainThread:expectation];
                                 }];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout
                                 handler:^(NSError *error) {
                                     XCTAssertNotNil(resultError);
                                     XCTAssertNil(resultDictionary);
                                 }];
}

#pragma mark - Helper Methods

- (NSData *)generateValidJSONResponseData {
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{
                                                             @"key" : @"value"
                                                             }
                                                   options:0
                                                     error:nil];
    return data;
}

- (NSData *)generateInvalidJSONResponseData {
    NSData *data = [@"1" dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

@end
