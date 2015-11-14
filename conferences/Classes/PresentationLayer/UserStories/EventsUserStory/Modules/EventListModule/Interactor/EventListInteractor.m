//
//  EventListInteractor.m
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "EventListInteractor.h"
#import "EventListInteractorOutput.h"
#import "EventService.h"
#import "Event.h"
#import "EventPrototypeMapper.h"
#import "PlainEvent.h"

#import "EXTScope.h"

@implementation EventListInteractor

#pragma mark - EventListInteractorInput

- (void)updateEventList {
    @weakify(self)
    [self.eventService updateEventWithPredicate:nil completionBlock:^(id data, NSError *error) {
        @strongify(self);
        NSArray *events = [self getPlainEventsFromManagedObjects:data];
        
        [self.output didUpdateEventList:events];
    }];
}

- (NSArray *)obtainEventList {
    id managedObjectEvents = [self.eventService obtainEventWithPredicate:nil];
    
    NSArray *events = [self getPlainEventsFromManagedObjects:managedObjectEvents];
    
    return events;
}

#pragma mark - Private methods

- (NSArray *)getPlainEventsFromManagedObjects:(NSArray *)manajedObjectEvents {
    NSMutableArray *plainEvents = [NSMutableArray array];
    for (Event *managedObjectEvent in manajedObjectEvents) {
        PlainEvent *plainEvent = [PlainEvent new];
        
        [self.eventPrototypeMapper fillObject:plainEvent withObject:managedObjectEvent];
        
        [plainEvents addObject:plainEvent];
    }
    
    return [self sortEventsByDate:plainEvents];
}

- (NSArray *)sortEventsByDate:(NSMutableArray *)events {
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:NSStringFromSelector(@selector(startDate)) ascending:NO];
    events = [[events sortedArrayUsingDescriptors:@[sortDescriptor]] mutableCopy];
    
    return events;
}

@end