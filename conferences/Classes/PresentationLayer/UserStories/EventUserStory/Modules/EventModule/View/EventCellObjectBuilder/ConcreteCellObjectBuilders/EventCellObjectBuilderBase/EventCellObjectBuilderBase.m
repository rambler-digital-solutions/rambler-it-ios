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

#import "EventCellObjectBuilderBase.h"
#import "LectureInfoTableViewCellObject.h"
#import "EventDescriptionTableViewCellObject.h"
#import "PreviousEventTableViewCellObject.h"
#import "PreviousEventSectionHeaderTableViewCellObject.h"
#import "PreviousLectureSectionHeaderTableViewCellObject.h"
#import "PreviousLectureTableViewCellObject.h"
#import "EventPlainObject.h"
#import "DateFormatter.h"
#import "EventCellObjectBuilderConstants.h"

@implementation EventCellObjectBuilderBase

- (NSArray *)cellObjectsForEvent:(EventPlainObject *)event
                      pastEvents:(NSArray *)pastEvents {
    return nil;
}

- (NSArray *)cellObjectsForLectureSectionWithEvent:(EventPlainObject *)event {
    NSMutableArray *cellObjects = [NSMutableArray new];
    
    if (event.lectures.count) {
        EventDescriptionTableViewCellObject *cellObject = [EventDescriptionTableViewCellObject objectWithEvent:event];
        [cellObjects addObject:cellObject];
    }
    
    for (LecturePlainObject *lecture in event.lectures) {
        LectureInfoTableViewCellObject *lectureCellobject = [LectureInfoTableViewCellObject objectWithLecture:lecture];
        [cellObjects addObject:lectureCellobject];
    }
    
    return cellObjects;
}

- (NSArray *)cellObjectsForPastEventsSectionWithCurrentEvent:(EventPlainObject *)event
                                                  pastEvents:(NSArray *)pastEvents {
    NSMutableArray *cellObjects = [NSMutableArray new];

    NSArray *filteredPastEvents = [self filterPastEvents:pastEvents];
    if (filteredPastEvents.count) {
        PreviousEventSectionHeaderTableViewCellObject *cellObject = [PreviousEventSectionHeaderTableViewCellObject objectWithEvent:event];
        [cellObjects addObject:cellObject];
    }
    
    for (EventPlainObject *pastEvent in filteredPastEvents) {
        NSString *date = [self.dateFormatter obtainDateWithDayMonthFormat:pastEvent.startDate];
        PreviousEventTableViewCellObject *eventCellobject = [PreviousEventTableViewCellObject objectWithEvent:pastEvent
                                                                                                      andDate:date];
        [cellObjects addObject:eventCellobject];
    }
    
    return cellObjects;
}

- (NSArray *)cellObjectsForPastLecturesSectionWithCurrentEvent:(EventPlainObject *)event
                                                    pastEvents:(NSArray *)pastEvents {
    NSMutableArray *cellObjects = [NSMutableArray new];
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
