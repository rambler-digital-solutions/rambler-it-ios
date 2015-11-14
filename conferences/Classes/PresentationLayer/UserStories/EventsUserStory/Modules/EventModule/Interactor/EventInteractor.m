//
//  EventInteractor.m
//  Conferences
//
//  Created by Karpushin Artem on 01/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "EventInteractor.h"
#import "EventInteractorOutput.h"
#import "EventService.h"
#import "PlainEvent.h"
#import "PrototypeMapper.h"
#import "EventTypeSetter.h"

static NSString *const kEventByObjectIdPredicateFormat = @"objectId = %@";

@implementation EventInteractor

#pragma mark - EventListInteractorInput

- (PlainEvent *)obtainEventByObjectId:(NSString *)objectId {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:kEventByObjectIdPredicateFormat, objectId];
    
    NSArray *events = [self.eventService obtainEventWithPredicate:predicate];
    id managedObjectEvent = [events firstObject];
    
    PlainEvent *plainEvent = [self getPlainEventFromManagedObject:managedObjectEvent];
    
    return plainEvent;
}

- (void)updateEventByObjectId:(NSString *)objectId {
    // TODO: implement method
    [self.output didUpdateEvent:nil];
}

#pragma mark - Private methods

- (PlainEvent *)getPlainEventFromManagedObject:(NSManagedObjectModel *)managedObjectEvent {
    PlainEvent *plainEvent = [PlainEvent new];
    [self.eventPrototypeMapper fillObject:plainEvent withObject:managedObjectEvent];
    
    [self.eventTypeSetter setTypeForEvent:plainEvent];
    
    return plainEvent;
}

@end