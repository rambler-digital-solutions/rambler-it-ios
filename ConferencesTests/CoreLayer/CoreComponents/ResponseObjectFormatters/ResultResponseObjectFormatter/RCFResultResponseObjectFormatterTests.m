//
//  RCFResultResponseObjectFormatterTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "RCFResultsResponseObjectFormatter.h"

@interface RCFResultResponseObjectFormatterTests : XCTestCase

@property (strong, nonatomic) RCFResultsResponseObjectFormatter *formatter;

@end

@implementation RCFResultResponseObjectFormatterTests

- (void)setUp {
    [super setUp];
    self.formatter = [[RCFResultsResponseObjectFormatter alloc] init];
}

- (void)tearDown {
    self.formatter = nil;
    [super tearDown];
}

- (void)testThatFormatterFormatsResponse {
    // given
    NSArray *resultsArray = @[@"1", @"2", @"3"];
    NSDictionary *response = @{
                               @"results" : resultsArray
                               };
    NSUInteger const kExpectedNumberOfItems = resultsArray.count;
    
    // when
    NSArray *result = [self.formatter formatServerResponse:response];
    
    // then
    XCTAssertTrue([result isKindOfClass:[NSArray class]]);
    XCTAssertEqual(result.count, kExpectedNumberOfItems);
}

@end
