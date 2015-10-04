//
//  CommonNetworkClientTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

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
    [self.client sendRequest:request resultBlock:nil];
    
    // then
    OCMVerify([self.mockSession dataTaskWithRequest:request
                                  completionHandler:OCMOCK_ANY]);
}
                             
#pragma mark - Helper Methods
                             
- (NSURLRequest *)generatePreconfiguredRequest {
    NSURL *targetURL = [NSURL URLWithString:kTestURLPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    return request;
}

@end
