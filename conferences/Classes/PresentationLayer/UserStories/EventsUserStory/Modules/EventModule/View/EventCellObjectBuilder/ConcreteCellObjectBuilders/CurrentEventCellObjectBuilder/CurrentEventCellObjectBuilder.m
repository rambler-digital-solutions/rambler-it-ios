//
//  CurrentEventCellObjectFactory.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "CurrentEventCellObjectBuilder.h"
#import "EventInfoTableViewCellObject.h"
#import "CurrentVideoTranslationTableViewCellObject.h"

typedef NS_ENUM(NSInteger, EventTableViewFormElementID) {
    EventInfoTableViewCellObjectID = 0,
    CurrentVideoTranslationTableViewCellObjectID = 1
};

@implementation CurrentEventCellObjectBuilder

- (NSArray *)cellObjectsForEvent:(PlainEvent *)event {
    NSMutableArray *cellObjects = [NSMutableArray array];
    
    EventInfoTableViewCellObject *eventInfoCellObject = [EventInfoTableViewCellObject objectWithElementID:EventInfoTableViewCellObjectID
                                                                                     event:event];
    [cellObjects addObject:eventInfoCellObject];
    
    CurrentVideoTranslationTableViewCellObject *videoTranslationCellObject = [CurrentVideoTranslationTableViewCellObject objectWithElementID:CurrentVideoTranslationTableViewCellObjectID
                                                                                                                  event:event];
    [cellObjects addObject:videoTranslationCellObject];
    
    return cellObjects;
}

@end
