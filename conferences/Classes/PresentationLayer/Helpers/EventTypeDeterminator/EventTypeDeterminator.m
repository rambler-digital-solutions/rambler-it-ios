//
//  EventTypeSetter.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventTypeDeterminator.h"
#import "PlainEvent.h"
#import "EventType.h"

@implementation EventTypeDeterminator

- (EventType)determinateTypeForEvent:(PlainEvent *)event {
    NSDate *currentDate = [NSDate date];
    
    NSComparisonResult result1 = [event.startDate compare:currentDate];
    NSComparisonResult result2 = [event.endDate compare:currentDate];
    
    if ((result1 == NSOrderedAscending) && (result2 == NSOrderedDescending)) {
        return CurrentEvent;
    }
    
    if (result1 == NSOrderedDescending) {
        return FutureEvent;
    }
    
    if (result2 == NSOrderedAscending) {
        return PastEvent;
    } else {
        return PastEvent;
    }
}

@end
