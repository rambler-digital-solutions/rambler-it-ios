//
//  DateFormatter.m
//  Conferences
//
//  Created by Karpushin Artem on 06/12/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "DateFormatter.h"

static NSString *const DayMonthTimeDateFormat = @"d MMMM в hh:mm";
static NSString *const DayMonthYearDateFormat = @"d MMMM yyyy";
static NSString *const DayMonthDateFormat = @"d MMMM";
static NSString *const MonthDateFormat = @"MMMM";
static NSString *const DayDateFormat = @"d";
static NSString *const TimeDateFormat = @"hh:mm";

@implementation DateFormatter

#pragma mark - Public methods

- (NSString *)obtainDateWithDayMonthTimeFormat:(NSDate *)date {
    return [self obtainDateWithFormat:DayMonthTimeDateFormat date:date];
}

- (NSString *)obtainDateWithDayMonthYearFormat:(NSDate *)date {
    return [self obtainDateWithFormat:DayMonthYearDateFormat date:date];
}

- (NSString *)obtainDateWithDayMonthFormat:(NSDate *)date {
    return [self obtainDateWithFormat:DayMonthDateFormat date:date];
}

- (NSString *)obtainDateWithMonthFormat:(NSDate *)date {
    return [self obtainDateWithFormat:MonthDateFormat date:date];
}

- (NSString *)obtainDateWithDayFormat:(NSDate *)date {
    return [self obtainDateWithFormat:DayDateFormat date:date];
}

- (NSString *)obtainDateWithTimeFormat:(NSDate *)date {
    return [self obtainDateWithFormat:TimeDateFormat date:date];
}

#pragma mark - Private methods

- (NSString *)obtainDateWithFormat:(NSString *)format date:(NSDate *)date {
    NSString *deviceLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:deviceLanguage];
    
    [dateFormatter setDateFormat:format];
    [dateFormatter setLocale:locale];
    
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

@end
