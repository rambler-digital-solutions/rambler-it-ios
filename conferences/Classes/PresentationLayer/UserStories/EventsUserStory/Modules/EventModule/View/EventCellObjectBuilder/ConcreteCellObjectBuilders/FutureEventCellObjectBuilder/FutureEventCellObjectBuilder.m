//
//  FutureEventCellObjectFactory.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "FutureEventCellObjectBuilder.h"
#import "EventInfoTableViewCellObject.h"
#import "SignUpAndSaveToCalendarEventTableViewCellObject.h"
#import "EventDescriptionTableViewCellObject.h"
#import "LectureInfoTableViewCellObject.h"
#import "PlainEvent.h"
#import "PlainLecture.h"

@implementation FutureEventCellObjectBuilder

- (NSArray *)cellObjectsForEvent:(PlainEvent *)event {
    NSMutableArray *cellObjects = [NSMutableArray array];
    
    EventInfoTableViewCellObject *eventInfoCellObject = [EventInfoTableViewCellObject objectWithEvent:event];
    [cellObjects addObject:eventInfoCellObject];
    
    SignUpAndSaveToCalendarEventTableViewCellObject *signUpCellObject = [SignUpAndSaveToCalendarEventTableViewCellObject objectWithEvent:event];
    [cellObjects addObject:signUpCellObject];
    
    EventDescriptionTableViewCellObject *eventDescriptionCellObject = [EventDescriptionTableViewCellObject objectWithEvent:event];
    [cellObjects addObject:eventDescriptionCellObject];
    
    for (PlainLecture *lecture in event.lectures) {
        LectureInfoTableViewCellObject *lectureCellobject = [LectureInfoTableViewCellObject objectWithLecture:lecture];
        [cellObjects addObject:lectureCellobject];
    }
    
    return cellObjects;
}

@end
