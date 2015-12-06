//
//  PastEventCellObjectFactory.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "PastEventCellObjectBuilder.h"

#import "EventInfoTableViewCellObject.h"
#import "PastVideoTranslationTableViewCellObject.h"
#import "EventDescriptionTableViewCellObject.h"
#import "LectureInfoTableViewCellObject.h"
#import "PlainEvent.h"
#import "PlainLecture.h"
#import "DateFormatter.h"

@implementation PastEventCellObjectBuilder

- (NSArray *)cellObjectsForEvent:(PlainEvent *)event {
    NSMutableArray *cellObjects = [NSMutableArray array];
    
    NSString *formattedDate = [self.dateFormatter obtainDateWithDayMonthTimeFormat:event.startDate];
    
    EventInfoTableViewCellObject *eventInfoCellObject = [EventInfoTableViewCellObject objectWithEvent:event andDate:formattedDate];
    [cellObjects addObject:eventInfoCellObject];
    
    PastVideoTranslationTableViewCellObject *videoCellObject = [PastVideoTranslationTableViewCellObject objectWithEvent:event];
    [cellObjects addObject:videoCellObject];
    
    EventDescriptionTableViewCellObject *eventDescriptionCellObject = [EventDescriptionTableViewCellObject objectWithEvent:event];
    [cellObjects addObject:eventDescriptionCellObject];
    
    for (PlainLecture *lecture in event.lectures) {
        LectureInfoTableViewCellObject *lectionCellobject = [LectureInfoTableViewCellObject objectWithLecture:lecture];
        [cellObjects addObject:lectionCellobject];
    }
    
    return cellObjects;
}

@end
