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
