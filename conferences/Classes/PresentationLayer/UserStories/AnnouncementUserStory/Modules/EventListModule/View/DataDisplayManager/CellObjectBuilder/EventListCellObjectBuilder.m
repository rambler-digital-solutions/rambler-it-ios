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

#import "EventListCellObjectBuilder.h"

#import "EventListTableViewCellObject.h"
#import "EventPlainObject.h"
#import "DateFormatter.h"

@implementation EventListCellObjectBuilder

- (NSArray *)buildCellObjectsWithEvents:(NSArray *)events {
    NSMutableArray *objects = [NSMutableArray new];
    for (EventPlainObject *event in events) {
        NSString *date = [self obtainDateForEvent:event];
        NSString *time = [self.dateFormatter obtainDateWithTimeFormat:event.startDate];
        EventListTableViewCellObject *object = [EventListTableViewCellObject objectWithEvent:event
                                                                                                   eventDate:date
                                                                                                        time:time
                                                                                        customBackgroundFlag:NO];
        [objects addObject:object];
    }
    
    return [objects copy];
}

- (NSString *)obtainDateForEvent:(EventPlainObject *)event {
    NSDate *eventDate = event.startDate;
    NSDate *currentDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *eventDateComponents = [calendar components:NSCalendarUnitYear
                                                        fromDate:eventDate];
    NSDateComponents *currentDateComponents = [calendar components:NSCalendarUnitYear
                                                          fromDate:currentDate];
    NSInteger eventYear = eventDateComponents.year;
    NSInteger currentYear = currentDateComponents.year;
    
    NSString *result;
    if (eventYear == currentYear) {
        result = [self.dateFormatter obtainDateWithDayMonthFormat:eventDate];
    } else {
        result = [self.dateFormatter obtainDateWithDayMonthYearFormat:eventDate];
    }
    return result;
}

@end
