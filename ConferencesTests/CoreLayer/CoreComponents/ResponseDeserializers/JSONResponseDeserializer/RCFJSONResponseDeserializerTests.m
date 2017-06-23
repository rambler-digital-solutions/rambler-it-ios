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

#import "XCTestCase+RCFHelpers.h"
#import "TestConstants.h"

#import "JSONResponseDeserializer.h"

@interface RCFJSONResponseDeserializerTests : XCTestCase

@property (nonatomic, strong) JSONResponseDeserializer *deserializer;

@end

@implementation RCFJSONResponseDeserializerTests

- (void)setUp {
    [super setUp];
    
    self.deserializer = [[JSONResponseDeserializer alloc] init];
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
