//
//  EventListProcessor.m
//  Conferences
//
//  Created by Trishina Ekaterina on 11/11/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "EventListProcessor.h"

@implementation EventListProcessor

+ (NSArray *)sortEventsByDate:(NSArray *)events {
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:NSStringFromSelector(@selector(startDate)) ascending:NO];
    events = [[events sortedArrayUsingDescriptors:@[sortDescriptor]] mutableCopy];

    return events;
}

@end
