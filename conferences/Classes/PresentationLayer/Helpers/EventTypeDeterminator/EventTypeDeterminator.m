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
    
    NSComparisonResult startDateComparisonResult = [event.startDate compare:currentDate];
    NSComparisonResult endDateComparisonResult = [event.endDate compare:currentDate];
    
    if ((startDateComparisonResult == NSOrderedAscending) && (endDateComparisonResult == NSOrderedDescending)) {
        return CurrentEvent;
    }
    
    if (startDateComparisonResult == NSOrderedDescending) {
        return FutureEvent;
    }
    
    if (endDateComparisonResult == NSOrderedAscending) {
        return PastEvent;
    } else {
        return PastEvent;
    }
}

@end
