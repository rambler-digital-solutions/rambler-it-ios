//
//  EventServiceEmplementation.m
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <MagicalRecord/MagicalRecord.h>

#import "EventServiceImplementation.h"

#import "CompoundOperationBase.h"
#import "EventOperationFactory.h"
#import "OperationScheduler.h"
#import "Event.h"

@implementation EventServiceImplementation

- (void)updateEventWithPredicate:(NSPredicate *)predicate completionBlock:(EventCompletionBlock)completionBlock {
    CompoundOperationBase *compoundOperation = [self.eventOperationFactory getEventsOperationWithQuery:nil];
    compoundOperation.resultBlock = ^void(id data, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(data, error);
        });
    };
    
    [self.operationScheduler addOperation:compoundOperation];
}

- (NSArray *)obtainEventWithPredicate:(NSPredicate *)predicate {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    NSArray *events = [Event MR_findAllWithPredicate:predicate inContext:context];
    
    return events;
}

@end
