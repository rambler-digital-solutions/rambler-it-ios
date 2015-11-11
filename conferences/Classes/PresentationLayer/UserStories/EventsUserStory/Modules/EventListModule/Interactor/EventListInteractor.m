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
        NSMutableArray *events = [NSMutableArray array];
        
        if ([data isKindOfClass:[NSArray class]]) {
            events = [self mapEventsManagedObjectsToPlainObjects:data];
        }
        [self.output didUpdateEventList:events];
    }];
}

- (NSArray *)obtainEventList {
    id managedObjectEvents = [self.eventService obtainEventWithPredicate:nil];
    
    NSMutableArray *events = [NSMutableArray array];
    
    if ([managedObjectEvents isKindOfClass:[NSArray class]]) {
        events = [self mapEventsManagedObjectsToPlainObjects:managedObjectEvents];
    }
    return events;
}

#pragma mark - Private methods

- (NSMutableArray *)mapEventsManagedObjectsToPlainObjects:(NSArray *)manajedObjectEvents {
    NSMutableArray *plainEvents = [NSMutableArray array];
    for (Event *managedObjectEvent in manajedObjectEvents) {
        PlainEvent *plainEvent = [PlainEvent new];
        
        [self.eventPrototypeMapper fillObject:plainEvent withObject:managedObjectEvent];
        
        [plainEvents addObject:plainEvent];
    }
    return [self sortEventsByDate:plainEvents];
}

- (NSMutableArray *)sortEventsByDate:(NSMutableArray *)events {
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:NO];
    events = [[events sortedArrayUsingDescriptors:@[sortDescriptor]] mutableCopy];
    
    return events;
}

@end