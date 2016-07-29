//
//  DateFormatterTests.m
//  Conferences
//
//  Created by Karpushin Artem on 06/12/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DateFormatter.h"

@interface DateFormatterTests : XCTestCase

@property (strong, nonatomic) DateFormatter *dateFormatter;
@property (strong, nonatomic) NSDate *date;

@end

@implementation DateFormatterTests

- (void)setUp {
    [super setUp];

    self.dateFormatter = [DateFormatter new];
    
    NSString *stringDate = @"2015-12-06 12:39:05";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    self.date = [dateFormatter dateFromString:stringDate];
}

- (void)tearDown {
    self.dateFormatter = nil;
    self.date = nil;
    
    [super tearDown];
}

- (void)testSuccessObtainDateWithDayMonthTimeFormat {
    // given
    NSString *expectedFormattedDateString = @"6 December в 12:39";
    NSString *actualFormattedDateString = nil;
    
    // when
    actualFormattedDateString = [self.dateFormatter obtainDateWithDayMonthTimeFormat:self.date];

    // then
    XCTAssertEqualObjects(expectedFormattedDateString, actualFormattedDateString);
}

- (void)testSuccessObtainDateWithDayMonthYearFormat {
    // given
    NSString *expectedFormattedDateString = @"6 December 2015";
    NSString *actualFormattedDateString = nil;
    
    // when
    actualFormattedDateString = [self.dateFormatter obtainDateWithDayMonthYearFormat:self.date];
    
    // then
    XCTAssertEqualObjects(expectedFormattedDateString, actualFormattedDateString);
}

- (void)testSuccessObtainDateWithDayMonthFormat {
    // given
    NSString *expectedFormattedDateString = @"6 December";
    NSString *actualFormattedDateString = nil;
    
    // when
    actualFormattedDateString = [self.dateFormatter obtainDateWithDayMonthFormat:self.date];
    
    // then
    XCTAssertEqualObjects(expectedFormattedDateString, actualFormattedDateString);
}

- (void)testSuccessObtainDateWithMonthFormat {
    // given
    NSString *expectedFormattedDateString = @"December";
    NSString *actualFormattedDateString = nil;
    
    // when
    actualFormattedDateString = [self.dateFormatter obtainDateWithMonthFormat:self.date];
    
    // then
    XCTAssertEqualObjects(expectedFormattedDateString, actualFormattedDateString);
}

- (void)testSuccessObtainDateWithDayFormat {
    // given
    NSString *expectedFormattedDateString = @"6";
    NSString *actualFormattedDateString = nil;
    
    // when
    actualFormattedDateString = [self.dateFormatter obtainDateWithDayFormat:self.date];
    
    // then
    XCTAssertEqualObjects(expectedFormattedDateString, actualFormattedDateString);
}

- (void)testSuccessObtainDateWithTimeFormat {
    // given
    NSString *expectedFormattedDateString = @"12:39";
    NSString *actualFormattedDateString = nil;
    
    // when
    actualFormattedDateString = [self.dateFormatter obtainDateWithTimeFormat:self.date];
    
    // then
    XCTAssertEqualObjects(expectedFormattedDateString, actualFormattedDateString);
}

@end
