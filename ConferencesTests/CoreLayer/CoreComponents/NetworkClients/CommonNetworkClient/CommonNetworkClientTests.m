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

#import "XCTestCase+RCFHelpers.h"
#import "TestConstants.h"

#import "CommonNetworkClient.h"

static NSString *const kTestURLPath = @"https://myapi.com/v1/rest";

@interface CommonNetworkClientTests : XCTestCase

@property (strong, nonatomic) CommonNetworkClient *client;
@property (strong, nonatomic) id mockSession;

@end

@implementation CommonNetworkClientTests

- (void)setUp {
    [super setUp];
    
    self.mockSession = OCMClassMock([NSURLSession class]);
    self.client = [[CommonNetworkClient alloc] initWithURLSession:self.mockSession];
}

- (void)tearDown {
    self.client = nil;
    self.mockSession = nil;
    
    [super tearDown];
}

- (void)testThatClientSendsRequests {
    // given
    NSURLRequest *request = [self generatePreconfiguredRequest];
    
    // when
    [self.client sendRequest:request
             completionBlock:nil];
    
    // then
    OCMVerify([self.mockSession dataTaskWithRequest:request
                                  completionHandler:OCMOCK_ANY]);
}

- (void)testThatClientCallsCompletionBlockWithData {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    NSURLRequest *request = [self generatePreconfiguredRequest];
    
    NSData *testData = [NSData new];
    
    [self stubSessionToAutocompleteWithRequest:request
                                          data:testData
                                         error:nil];
    __block id resultData;
    
    // when
    [self.client sendRequest:request
             completionBlock:^(NSData *data, NSError *error) {
        resultData = data;
        [expectation fulfill];
    }];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout
                                 handler:^(NSError * _Nullable error) {
        XCTAssertEqualObjects(resultData, testData);
    }];
}

- (void)testThatClientCallsCompletionBlockWithError {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    NSURLRequest *request = [self generatePreconfiguredRequest];
    
    NSError *clientError = [NSError errorWithDomain:@"Test Domain"
                                               code:0
                                           userInfo:nil];
    
    [self stubSessionToAutocompleteWithRequest:request
                                          data:nil
                                         error:clientError];
    __block id resultError;
    
    // when
    [self.client sendRequest:request
             completionBlock:^(NSData *data, NSError *error) {
                 resultError = error;
                 [expectation fulfill];
             }];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertEqualObjects(resultError, clientError);
                                 }];
}
                             
#pragma mark - Helper Methods
                             
- (NSURLRequest *)generatePreconfiguredRequest {
    NSURL *targetURL = [NSURL URLWithString:kTestURLPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    return request;
}

- (void)stubSessionToAutocompleteWithRequest:(NSURLRequest *)request
                                                 data:(NSData *)data
                                                error:(NSError *)error {
    ProxyBlock proxyBlock = ^(NSInvocation *invocation) {
        void (^completionBlock)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error);
        [invocation getArgument:&completionBlock atIndex:3];
        
        completionBlock(data, nil, error);
    };
    OCMStub([self.mockSession dataTaskWithRequest:request
                                completionHandler:OCMOCK_ANY]).andDo(proxyBlock);
}

@end
