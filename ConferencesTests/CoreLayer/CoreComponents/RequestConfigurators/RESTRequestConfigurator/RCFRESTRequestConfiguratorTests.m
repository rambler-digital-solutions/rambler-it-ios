//
//  RCFRESTRequestConfiguratorTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 03/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NetworkingConstantsHeader.h"

#import "RCFRESTRequestConfigurator.h"
#import "RCFRequestDataModel.h"

static NSString *const kTestBaseURLPath = @"https://myapi.com";
static NSString *const kTestBaseAPIPath = @"/v1/rest/";

@interface RCFRESTRequestConfiguratorTests : XCTestCase

@property (strong, nonatomic) RCFRESTRequestConfigurator *configurator;

@end

@implementation RCFRESTRequestConfiguratorTests

- (void)setUp {
    [super setUp];
    
    NSURL *baseURL = [NSURL URLWithString:kTestBaseURLPath];
    self.configurator = [[RCFRESTRequestConfigurator alloc] initWithBaseURL:baseURL
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
    
    RCFRequestDataModel *dataModel = [[RCFRequestDataModel alloc] init];
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
    
    RCFRequestDataModel *dataModel = [[RCFRequestDataModel alloc] init];
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
    
    self.configurator = [[RCFRESTRequestConfigurator alloc] initWithBaseURL:baseURL
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
