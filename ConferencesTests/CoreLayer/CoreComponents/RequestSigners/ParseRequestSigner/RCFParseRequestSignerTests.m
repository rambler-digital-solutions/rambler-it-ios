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
