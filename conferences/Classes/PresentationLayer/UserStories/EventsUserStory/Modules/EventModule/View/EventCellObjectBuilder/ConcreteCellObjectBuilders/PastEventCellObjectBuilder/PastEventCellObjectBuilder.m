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

typedef NS_ENUM(NSUInteger, EventTableViewFormElementID){
    EventInfoTableViewCellObjectID = 0,
    PastVideoTranslationTableViewCellObjectID = 1,
    EventDescriptionTableViewCellObjectID = 2,
};

@implementation PastEventCellObjectBuilder

- (NSArray *)cellObjectsForEvent:(PlainEvent *)event {
    NSMutableArray *cellObjects = [NSMutableArray array];
    
    EventInfoTableViewCellObject *eventInfoCellObject = [EventInfoTableViewCellObject objectWithElementID:EventDescriptionTableViewCellObjectID
                                                                                     event:event];
    [cellObjects addObject:eventInfoCellObject];
    
    PastVideoTranslationTableViewCellObject *videoCellObject = [PastVideoTranslationTableViewCellObject objectWithElementID:PastVideoTranslationTableViewCellObjectID
                                                                                                            event:event];
    [cellObjects addObject:videoCellObject];
    
    EventDescriptionTableViewCellObject *eventDescriptionCellObject = [EventDescriptionTableViewCellObject objectWithElementID:EventDescriptionTableViewCellObjectID
                                                                                                          event:event];
    [cellObjects addObject:eventDescriptionCellObject];
    
    for (PlainLecture *lecture in event.lectures) {
        LectureInfoTableViewCellObject *lectionCellobject = [LectureInfoTableViewCellObject objectWithLecture:lecture];
        [cellObjects addObject:lectionCellobject];
    }
    
    // пока не реализовано получение докладов с сервера, имитируем их наличие
//    LectureInfoTableViewCellObject *lection1 = [LectureInfoTableViewCellObject new];
//    LectureInfoTableViewCellObject *lection2 = [LectureInfoTableViewCellObject new];
//    LectureInfoTableViewCellObject *lection3 = [LectureInfoTableViewCellObject new];
//    
//    [cellObjects addObject:lection1];
//    [cellObjects addObject:lection2];
//    [cellObjects addObject:lection3];
//    [cellObjects addObject:lection3];
    
    return cellObjects;
}

@end
