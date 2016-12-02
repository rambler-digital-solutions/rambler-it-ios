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

#import "NetworkingConstantsHeader.h"

#import "RESTRequestConfigurator.h"
#import "RequestDataModel.h"

static NSString *const kTestBaseURLPath = @"https://myapi.com";
static NSString *const kTestBaseAPIPath = @"/v1/rest/";

@interface RCFRESTRequestConfiguratorTests : XCTestCase

@property (nonatomic, strong) RESTRequestConfigurator *configurator;

@end

@implementation RCFRESTRequestConfiguratorTests

- (void)setUp {
    [super setUp];
    
    NSURL *baseURL = [NSURL URLWithString:kTestBaseURLPath];
    self.configurator = [[RESTRequestConfigurator alloc] initWithBaseURL:baseURL
                                                                    apiPath:kTestBaseAPIPath];
}

- (void)tearDown {
    self.configurator = nil;
    
    [super tearDown];
}

- (void)testThatConfiguratorCreatesSimpleRequest {
    // given
    NSString *expectedURLPath = @"https://myapi.com/v1/rest/";
    
    // when
    NSURLRequest *result = [self.configurator requestWithMethod:kHTTPMethodGET
                                                    serviceName:nil
                                                  urlParameters:nil
                                               requestDataModel:nil];
    
    // then
    XCTAssertEqualObjects(result.URL.absoluteString, expectedURLPath);
    XCTAssertEqualObjects(result.HTTPMethod, @"GET");
}

- (void)testThatConfiguratorCreatesRequestWithPath {
    // given
    NSString *expectedURLPath = @"https://myapi.com/v1/rest/service/object";
    
    // when
    NSURLRequest *result = [self.configurator requestWithMethod:kHTTPMethodGET
                                                    serviceName:@"service"
                                                  urlParameters:@[@"object"]
                                               requestDataModel:nil];
    
    // then
    XCTAssertEqualObjects(result.URL.absoluteString, expectedURLPath);
    XCTAssertEqualObjects(result.HTTPMethod, @"GET");
}

- (void)testThatConfiguratorCreatesQueryRequests {
    // given
    NSString *expectedURLPath = @"https://myapi.com/v1/rest/service/object?key1=value1&key2=value2";
    
    RequestDataModel *dataModel = [[RequestDataModel alloc] init];
    dataModel.queryParameters = [self generateRequestParameters];
    
    // when
    NSURLRequest *result = [self.configurator requestWithMethod:kHTTPMethodGET
                                                    serviceName:@"service"
                                                  urlParameters:@[@"object"]
                                               requestDataModel:dataModel];
    
    // then
    XCTAssertEqualObjects(result.URL.absoluteString, expectedURLPath);
    XCTAssertEqualObjects(result.HTTPMethod, @"GET");
}

- (void)testThatConfiguratorCreatesBodyRequests {
    // given
    NSString *expectedURLPath = @"https://myapi.com/v1/rest/service/object";
    
    RequestDataModel *dataModel = [[RequestDataModel alloc] init];
    dataModel.bodyData = [self generateBodyData];
    
    // when
    NSURLRequest *result = [self.configurator requestWithMethod:kHTTPMethodPOST
                                                    serviceName:@"service"
                                                  urlParameters:@[@"object"]
                                               requestDataModel:dataModel];
    
    // then
    XCTAssertEqualObjects(result.URL.absoluteString, expectedURLPath);
    XCTAssertEqualObjects(result.HTTPMethod, @"POST");
    XCTAssertEqualObjects(result.HTTPBody, dataModel.bodyData);
}

- (void)testThatConfiguratorFiltersSlashes {
    // given
    NSString *expectedURLPath = @"https://myapi.com/v1/rest";
    NSURL *baseURL = [NSURL URLWithString:@"https://myapi.com"];
    NSString *apiPath = @"/v1//rest";
    
    self.configurator = [[RESTRequestConfigurator alloc] initWithBaseURL:baseURL
                                                                    apiPath:apiPath];
    
    // when
    NSURLRequest *result = [self.configurator requestWithMethod:kHTTPMethodGET
                                                    serviceName:nil
                                                  urlParameters:nil
                                               requestDataModel:nil];
    
    // then
    XCTAssertEqualObjects(result.URL.absoluteString, expectedURLPath);
    XCTAssertEqualObjects(result.HTTPMethod, @"GET");
}

#pragma mark - Helper methods

- (NSDictionary *)generateRequestParameters {
    return @{
             @"key1" : @"value1",
             @"key2" : @"value2"
             };
}

- (NSData *)generateBodyData {
    NSString *dataString = @"test body data";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

@end
