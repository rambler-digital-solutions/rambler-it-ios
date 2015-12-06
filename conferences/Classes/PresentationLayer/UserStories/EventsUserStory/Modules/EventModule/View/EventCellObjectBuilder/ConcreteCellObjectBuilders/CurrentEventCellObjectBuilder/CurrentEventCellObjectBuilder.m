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
#import "DateFormatter.h"
#import "PlainEvent.h"

@implementation CurrentEventCellObjectBuilder

- (NSArray *)cellObjectsForEvent:(PlainEvent *)event {
    NSMutableArray *cellObjects = [NSMutableArray array];
    
    NSString *formattedDate = [self.dateFormatter obtainDateWithDayMonthTimeFormat:event.startDate];
    
    EventInfoTableViewCellObject *eventInfoCellObject = [EventInfoTableViewCellObject objectWithEvent:event andDate:formattedDate];
    [cellObjects addObject:eventInfoCellObject];
    
    CurrentVideoTranslationTableViewCellObject *videoTranslationCellObject = [CurrentVideoTranslationTableViewCellObject objectWithEvent:event];
    [cellObjects addObject:videoTranslationCellObject];
    
    return cellObjects;
}

@end
