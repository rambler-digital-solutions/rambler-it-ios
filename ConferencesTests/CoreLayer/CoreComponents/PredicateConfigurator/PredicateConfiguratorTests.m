//
//  PredicateConfiguratorTests.m
//  Conferences
//
//  Created by s.sarkisyan on 02.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PredicateConfiguratorImplementation.h"

@interface PredicateConfiguratorTests : XCTestCase

@property (nonatomic, strong) PredicateConfiguratorImplementation *predicateConfigurator;

@end

@implementation PredicateConfiguratorTests

- (void)setUp {
    [super setUp];
    
    self.predicateConfigurator = [PredicateConfiguratorImplementation new];
}

- (void)tearDown {
    self.predicateConfigurator = nil;
    
    [super tearDown];
}

- (void)testConfigureEventsPredicatesForSingleWord {
    //given
    NSString *searchText = @"ios";
    
    NSPredicate *singlePredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] \"ios\" OR SUBQUERY(lectures, $lecture, SUBQUERY($lecture.tags, $tag, $tag.name CONTAINS[c] \"ios\").@count > 0).@count > 0"];
    NSArray *predicatesArray = @[singlePredicate];
    
    //when
    NSArray *result = [self.predicateConfigurator configureEventsPredicatesForSearchText:searchText];
    
    //then
    XCTAssertEqualObjects(result, predicatesArray);
}

- (void)testConfigureEventsPredicatesForFewWords {
    //given
    NSString *searchText = @"ios nsoperation";

    NSPredicate *firstPredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] \"ios\" OR SUBQUERY(lectures, $lecture, SUBQUERY($lecture.tags, $tag, $tag.name CONTAINS[c] \"ios\").@count > 0).@count > 0"];
    NSPredicate *secondPredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] \"nsoperation\" OR SUBQUERY(lectures, $lecture, SUBQUERY($lecture.tags, $tag, $tag.name CONTAINS[c] \"nsoperation\").@count > 0).@count > 0"];
    NSArray *predicatesArray = @[firstPredicate, secondPredicate];
    
    //when
    NSArray *result = [self.predicateConfigurator configureEventsPredicatesForSearchText:searchText];
    
    //then
    XCTAssertEqualObjects(result, predicatesArray);
}

- (void)testConfigureSpeakersPredicatesForSingleWord {
    //given
    NSString *searchText = @"ios";

    NSPredicate *singlePredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] \"ios\""];
    NSArray *predicatesArray = @[singlePredicate];
    
    //when
    NSArray *result = [self.predicateConfigurator configureSpeakersPredicatesForSearchText:searchText];
    
    //then
    XCTAssertEqualObjects(result, predicatesArray);
}

- (void)testConfigureSpeakersPredicatesForFewWords {
    //given
    NSString *searchText = @"ios nsoperation";
    
    NSPredicate *firstPredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] \"ios\""];
    NSPredicate *secondPredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] \"nsoperation\""];
    NSArray *predicatesArray = @[firstPredicate, secondPredicate];
    
    //when
    NSArray *result = [self.predicateConfigurator configureSpeakersPredicatesForSearchText:searchText];
    
    //then
    XCTAssertEqualObjects(result, predicatesArray);
}

- (void)testConfigureLecturesPredicatesForSingleWord {
    //given
    NSString *searchText = @"ios";
    
    NSPredicate *singlePredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] \"ios\" OR SUBQUERY(tags, $tag, $tag.name CONTAINS[c] \"ios\").@count > 0 OR speaker.name CONTAINS[c] \"ios\""];
    NSArray *predicatesArray = @[singlePredicate];
    
    //when
    NSArray *result = [self.predicateConfigurator configureLecturesPredicatesForSearchText:searchText];
    
    //then
    XCTAssertEqualObjects(result, predicatesArray);
}

- (void)testConfigureLecturesPredicatesForFewWords {
    //given
    NSString *searchText = @"ios nsoperation";
    
    NSPredicate *firstPredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] \"ios\" OR SUBQUERY(tags, $tag, $tag.name CONTAINS[c] \"ios\").@count > 0 OR speaker.name CONTAINS[c] \"ios\""];
    NSPredicate *secondPredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] \"nsoperation\" OR SUBQUERY(tags, $tag, $tag.name CONTAINS[c] \"nsoperation\").@count > 0 OR speaker.name CONTAINS[c] \"nsoperation\""];
    NSArray *predicatesArray = @[firstPredicate, secondPredicate];
    
    //when
    NSArray *result = [self.predicateConfigurator configureLecturesPredicatesForSearchText:searchText];
    
    //then
    XCTAssertEqualObjects(result, predicatesArray);
}

@end
