//
//  EventInteractor.h
//  Conferences
//
//  Created by Karpushin Artem on 01/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventInteractorInput.h"

@protocol EventInteractorOutput;
@protocol EventService;
@protocol PrototypeMapper;
@class EventTypeDeterminator;

@interface EventInteractor : NSObject<EventInteractorInput>

@property (nonatomic, weak) id<EventInteractorOutput> output;
@property (strong, nonatomic) id <EventService> eventService;
@property (strong, nonatomic) id <PrototypeMapper> eventPrototypeMapper;
@property (strong, nonatomic) EventTypeDeterminator *eventTypeDeterminator;

@end

