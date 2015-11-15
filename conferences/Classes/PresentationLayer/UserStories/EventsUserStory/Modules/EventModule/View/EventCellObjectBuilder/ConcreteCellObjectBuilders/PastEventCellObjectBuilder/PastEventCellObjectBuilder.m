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
#import "LectionInfoTableViewCellObject.h"
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
        LectionInfoTableViewCellObject *lectionCellobject = [LectionInfoTableViewCellObject objectWithLecture:lecture];
        [cellObjects addObject:lectionCellobject];
    }
    
    LectionInfoTableViewCellObject *lection1 = [LectionInfoTableViewCellObject new];
    LectionInfoTableViewCellObject *lection2 = [LectionInfoTableViewCellObject new];
    LectionInfoTableViewCellObject *lection3 = [LectionInfoTableViewCellObject new];
    
    [cellObjects addObject:lection1];
    [cellObjects addObject:lection2];
    [cellObjects addObject:lection3];
    [cellObjects addObject:lection3];
    
    return cellObjects;
}

@end
