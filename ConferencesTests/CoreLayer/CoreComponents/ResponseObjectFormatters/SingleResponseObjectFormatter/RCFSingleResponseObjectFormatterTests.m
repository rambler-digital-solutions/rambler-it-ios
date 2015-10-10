//
//  RCFSingleResponseObjectFormatterTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "SingleResponseObjectFormatter.h"

@interface RCFSingleResponseObjectFormatterTests : XCTestCase

@property (strong, nonatomic) SingleResponseObjectFormatter *formatter;

@end

@implementation RCFSingleResponseObjectFormatterTests

- (void)setUp {
    [super setUp];
    
    self.formatter = [[SingleResponseObjectFormatter alloc] init];
}

- (void)tearDown {
    self.formatter = nil;
    
    [super tearDown];
}

- (void)testThatFormatterFormatsResponse {
    // given
    NSDictionary *response = @{
                               @"objectId" : @"hhFHh9sSc",
                               @"name" : @"Egor"
                               };
    NSUInteger const kExpectedNumberOfItems = 1;
    
    // when
    NSArray *result = [self.formatter formatServerResponse:response];
    
    // then
    XCTAssertTrue([result isKindOfClass:[NSArray class]]);
    XCTAssertEqual(result.count, kExpectedNumberOfItems);
}

@end
