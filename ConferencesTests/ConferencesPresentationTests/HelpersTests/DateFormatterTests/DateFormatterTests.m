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

@end

@implementation DateFormatterTests

- (void)setUp {
    [super setUp];

    self.dateFormatter = [DateFormatter new];
}

- (void)tearDown {
    self.dateFormatter = nil;
    
    [super tearDown];
}

- (void)testSuccessObtainDateWithDayMonthTimeFormat {
    // given
    NSDate *date = [NSDate date];
    
    // when
    NSString *formattedDate = [self.dateFormatter obtainDateWithDayMonthTimeFormat:date];
    NSLog(@"%@", formattedDate);
    NSLog(@"");
    // then
}

@end
