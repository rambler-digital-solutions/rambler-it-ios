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
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.date = [dateFormatter dateFromString:stringDate];
}

- (void)tearDown {
    self.dateFormatter = nil;
    self.date = nil;
    
    [super tearDown];
}

- (void)testSuccessObtainDateWithDayMonthYearTimeFormat {
    // given
    NSString *expectedFormattedDateString = @"6 December 2015 в 12:39";
    NSString *actualFormattedDateString = nil;
    
    // when
    actualFormattedDateString = [self.dateFormatter obtainDateWithDayMonthYearTimeFormat:self.date];
    
    // then
    XCTAssertEqualObjects(expectedFormattedDateString, actualFormattedDateString);
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
