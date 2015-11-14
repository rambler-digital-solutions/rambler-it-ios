//
//  EventInteractor.m
//  Conferences
//
//  Created by Karpushin Artem on 01/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "EventInteractor.h"
#import "EventInteractorOutput.h"

@implementation EventInteractor

- (PlainEvent *)obtainEventByObjectId:(NSString *)objectId {
    return nil;
}

- (void)updateEventByObjectId:(NSString *)objectId {
    [self.output didUpdateEvent:nil];
}

@end