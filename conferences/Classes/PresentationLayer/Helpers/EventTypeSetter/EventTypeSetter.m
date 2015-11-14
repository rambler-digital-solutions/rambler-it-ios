//
//  EventTypeSetter.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventTypeSetter.h"
#import "PlainEvent.h"
#import "EventType.h"

@implementation EventTypeSetter

- (void)setTypeForEvent:(PlainEvent *)event {
    NSDate *currentDate = [NSDate date];
    if ([event.startDate timeIntervalSinceReferenceDate] > [currentDate timeIntervalSinceReferenceDate]) {
        event.eventType = FutureEvent;
    }
    
    if ([event.startDate timeIntervalSinceReferenceDate] < [currentDate timeIntervalSinceReferenceDate] < [event.endDate timeIntervalSinceReferenceDate]) {
        event.eventType = CurrentEvent;
    }
    
    if ([currentDate timeIntervalSinceReferenceDate] > [event.endDate timeIntervalSinceReferenceDate]) {
        event.eventType = PastEvent;
    }
}

@end
