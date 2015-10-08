//
//  CommonNetworkClientTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

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
