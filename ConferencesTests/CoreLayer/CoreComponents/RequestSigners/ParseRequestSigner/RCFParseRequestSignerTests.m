//
//  ParseRequestSignerTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ParseRequestSigner.h"

static NSString *const kTestApplicationId = @"applicationId";
static NSString *const kTestApiKey = @"apiKey";
static NSString *const kTestURLPath = @"https://myapi.com/v1/rest";

@interface ParseRequestSignerTests : XCTestCase

@property (strong, nonatomic) ParseRequestSigner *signer;

@end

@implementation ParseRequestSignerTests

- (void)setUp {
    [super setUp];
    
    self.signer = [[ParseRequestSigner alloc] initWithApplicationId:kTestApplicationId
                                                                apiKey:kTestApiKey];
}

- (void)tearDown {
    self.signer = nil;
    
    [super tearDown];
}

- (void)testThatSignerSignsRequest {
    // given
    NSURL *targetURL = [NSURL URLWithString:kTestURLPath];
    NSURLRequest *unsignedURLRequest = [NSURLRequest requestWithURL:targetURL];
    
    // when
    NSURLRequest *result = [self.signer signRequest:unsignedURLRequest];
    NSString *resultApplicationId = [self parseApplicationIdFromRequest:result];
    NSString *resultApiKey = [self parseApiKeyFromRequest:result];
    
    // then
    XCTAssertEqualObjects(result.URL.absoluteString, kTestURLPath);
    XCTAssertEqualObjects(resultApplicationId, kTestApplicationId);
    XCTAssertEqualObjects(resultApiKey, kTestApiKey);
}

#pragma mark - Helper methods

- (NSString *)parseApplicationIdFromRequest:(NSURLRequest *)request {
    NSString *applicationId = [self parseHTTPHeaderValueFromRequest:request
                                                            withKey:@"X-Parse-Application-Id"];
    return applicationId;
}

- (NSString *)parseApiKeyFromRequest:(NSURLRequest *)request {
    NSString *apiKey = [self parseHTTPHeaderValueFromRequest:request
                                                     withKey:@"X-Parse-REST-API-Key"];
    return apiKey;
}

- (NSString *)parseHTTPHeaderValueFromRequest:(NSURLRequest *)request
                                      withKey:(NSString *)key {
    NSDictionary *headers = request.allHTTPHeaderFields;
    NSString *value = headers[key];
    return value;
}

@end
