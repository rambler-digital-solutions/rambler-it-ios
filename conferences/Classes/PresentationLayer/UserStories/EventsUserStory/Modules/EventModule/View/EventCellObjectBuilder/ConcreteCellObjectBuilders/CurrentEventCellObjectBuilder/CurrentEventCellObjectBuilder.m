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

@implementation CurrentEventCellObjectBuilder

- (NSArray *)cellObjectsForEvent:(PlainEvent *)event {
    NSMutableArray *cellObjects = [NSMutableArray array];
    
    EventInfoTableViewCellObject *eventInfoCellObject = [EventInfoTableViewCellObject objectWithEvent:event];
    [cellObjects addObject:eventInfoCellObject];
    
    CurrentVideoTranslationTableViewCellObject *videoTranslationCellObject = [CurrentVideoTranslationTableViewCellObject objectWithEvent:event];
    [cellObjects addObject:videoTranslationCellObject];
    
    return cellObjects;
}

@end
