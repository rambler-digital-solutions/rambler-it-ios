// Copyright (c) 2016 RAMBLER&Co
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
