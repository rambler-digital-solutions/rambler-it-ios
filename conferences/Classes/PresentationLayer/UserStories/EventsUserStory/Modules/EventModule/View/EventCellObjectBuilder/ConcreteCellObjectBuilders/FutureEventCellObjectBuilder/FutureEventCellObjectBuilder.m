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

typedef NS_ENUM(NSUInteger, EventTableViewFormElementID) {
    EventInfoTableViewCellObjectID = 0,
    SignUpAndSaveToCalendarEventTableViewCellObjectID = 1,
    EventDescriptionTableViewCellObjectID = 2,
};

@implementation FutureEventCellObjectBuilder

- (NSArray *)cellObjectsForEvent:(PlainEvent *)event {
    NSMutableArray *cellObjects = [NSMutableArray array];
    
    EventInfoTableViewCellObject *eventInfoCellObject = [EventInfoTableViewCellObject objectWithElementID:EventDescriptionTableViewCellObjectID
                                                                                     event:event];
    [cellObjects addObject:eventInfoCellObject];
    
    SignUpAndSaveToCalendarEventTableViewCellObject *signUpCellObject = [SignUpAndSaveToCalendarEventTableViewCellObject objectWithElementID:SignUpAndSaveToCalendarEventTableViewCellObjectID
                                                                                                                             event:event];
    [cellObjects addObject:signUpCellObject];
    
    EventDescriptionTableViewCellObject *eventDescriptionCellObject = [EventDescriptionTableViewCellObject objectWithElementID:EventDescriptionTableViewCellObjectID
                                                                                                          event:event];
    [cellObjects addObject:eventDescriptionCellObject];
    
    for (PlainLecture *lecture in event.lectures) {
        LectureInfoTableViewCellObject *lectureCellobject = [LectureInfoTableViewCellObject objectWithLecture:lecture];
        [cellObjects addObject:lectureCellobject];
    }
    
    // пока не реализовано получение докладов с сервера, имитируем их наличие
    LectureInfoTableViewCellObject *lection1 = [LectureInfoTableViewCellObject new];
    LectureInfoTableViewCellObject *lection2 = [LectureInfoTableViewCellObject new];
    LectureInfoTableViewCellObject *lection3 = [LectureInfoTableViewCellObject new];
    
    [cellObjects addObject:lection1];
    [cellObjects addObject:lection2];
    [cellObjects addObject:lection3];
    [cellObjects addObject:lection3];
    
    return cellObjects;
}

@end
