//
//  EventListQueryTransformerTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 02/07/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "EventListQueryTransformer.h"
#import "EventListQuery.h"

static NSString *const kLastModifiedFilterFormat = @"filter[modified_since]";

@interface EventListQueryTransformerTests : XCTestCase

@property (nonatomic, strong) EventListQueryTransformer *transformer;

@end

@implementation EventListQueryTransformerTests

- (void)setUp {
    [super setUp];
    
    self.transformer = [EventListQueryTransformer new];
}

- (void)tearDown {
    self.transformer = nil;
    
    [super tearDown];
}

- (void)testThatTransformerReturnsProperParametersForEmptyLastModified {
    // given
    EventListQuery *query = [EventListQuery new];
    
    // when
    NSArray *result = [self.transformer deriveUrlParametersFromQuery:query];
    
    // then
    XCTAssertTrue(result.count == 0);
}

- (void)testThatTransformerReturnsProperParametersForNonNilLastModified {
    // given
    NSString *const kTestLastModified = @"000000";
    
    EventListQuery *query = [EventListQuery new];
    query.lastModifiedString = kTestLastModified;
    
    // when
    NSDictionary *result = [self.transformer deriveUrlParametersFromQuery:query];
    
    // then
    NSString *obtainedLastModified = [result objectForKey:kLastModifiedFilterFormat];
    XCTAssertEqualObjects(obtainedLastModified, kTestLastModified);
}

@end
