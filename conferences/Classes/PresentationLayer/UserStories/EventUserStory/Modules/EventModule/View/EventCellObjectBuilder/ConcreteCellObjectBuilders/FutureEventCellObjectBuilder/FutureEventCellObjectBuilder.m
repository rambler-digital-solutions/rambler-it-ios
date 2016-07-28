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

#import "FutureEventCellObjectBuilder.h"
#import "EventInfoTableViewCellObject.h"
#import "SignUpAndSaveToCalendarEventTableViewCellObject.h"
#import "EventDescriptionTableViewCellObject.h"
#import "LectureInfoTableViewCellObject.h"
#import "EventPlainObject.h"
#import "LecturePlainObject.h"
#import "DateFormatter.h"
#import "PreviousLectureSectionHeaderTableViewCellObject.h"
#import "PreviousLectureTableViewCellObject.h"
#import "PreviousEventSectionHeaderTableViewCellObject.h"
#import "PreviousEventTableViewCellObject.h"
#import "TechPlainObject.h"

static NSInteger const kEventPastEventsCount = 2;
static NSInteger const kEventPastEventLecturesCount = 5;

@implementation FutureEventCellObjectBuilder

- (NSArray *)cellObjectsForEvent:(EventPlainObject *)event
                      pastEvents:(NSArray *)pastEvents {
    NSMutableArray *cellObjects = [NSMutableArray array];
    
    NSString *formattedDate = [self.dateFormatter obtainDateWithDayMonthTimeFormat:event.startDate];
    
    EventInfoTableViewCellObject *eventInfoCellObject = [EventInfoTableViewCellObject objectWithEvent:event andDate:formattedDate];
    [cellObjects addObject:eventInfoCellObject];
    
    SignUpAndSaveToCalendarEventTableViewCellObject *signUpCellObject = [SignUpAndSaveToCalendarEventTableViewCellObject objectWithEvent:event];
    [cellObjects addObject:signUpCellObject];
    
    for (LecturePlainObject *lecture in event.lectures) {
        LectureInfoTableViewCellObject *lectureCellobject = [LectureInfoTableViewCellObject objectWithLecture:lecture];
        [cellObjects addObject:lectureCellobject];
    }
    
    //Adding previous events section
    NSArray *filteredPastEvents = [self filterPastEvents:pastEvents];
    if (filteredPastEvents.count) {
        PreviousEventSectionHeaderTableViewCellObject *cellObject = [PreviousEventSectionHeaderTableViewCellObject objectWithEvent:event];
        [cellObjects addObject:cellObject];
    }
    
    for (EventPlainObject *pastEvent in filteredPastEvents) {
        NSString *date = [self.dateFormatter obtainDateWithDayMonthFormat:pastEvent.startDate];
        PreviousEventTableViewCellObject *lectureCellobject = [PreviousEventTableViewCellObject objectWithEvent:pastEvent
                                                                                                        andDate:date];
        [cellObjects addObject:lectureCellobject];
    }
    
    //Adding previous lectures section
    NSArray *pastLectures = [self filterPastLectures:pastEvents];
    
    if (pastLectures.count) {
        PreviousLectureSectionHeaderTableViewCellObject *cellObject = [PreviousLectureSectionHeaderTableViewCellObject objectWithEvent:event];
        [cellObjects addObject:cellObject];
    }
    
    for (LecturePlainObject *pastLecture in pastLectures) {
        PreviousLectureTableViewCellObject *lectureCellobject = [PreviousLectureTableViewCellObject objectWithLecture:pastLecture];
        [cellObjects addObject:lectureCellobject];
    }

    return cellObjects;
}

- (NSArray *)filterPastEvents:(NSArray *)events {
    if (!events.count) {
        return nil;
    }
    NSInteger eventCount = MIN(events.count, kEventPastEventsCount);
    NSArray *pastEvents = [events subarrayWithRange:NSMakeRange(0, eventCount)];
    
    return pastEvents;
}

- (NSArray *)filterPastLectures:(NSArray *)events {
    NSMutableArray *lectures = [NSMutableArray new];
    for (EventPlainObject *event in events) {
        [lectures addObjectsFromArray:[event.lectures allObjects]];
    }
    if (!lectures.count) {
        return nil;
    }
    NSInteger lectureCount = MIN(lectures.count, kEventPastEventLecturesCount);
    NSArray *pastLectures = [lectures subarrayWithRange:NSMakeRange(0, lectureCount)];
    
    return pastLectures;
}

@end
