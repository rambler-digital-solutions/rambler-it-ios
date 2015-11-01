//
//  EventListInteractor.h
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventListInteractorInput.h"

@protocol EventListInteractorOutput;
@protocol EventService;
@protocol PrototypeMapper;

@interface EventListInteractor : NSObject<EventListInteractorInput>

@property (nonatomic, weak) id<EventListInteractorOutput> output;
@property (strong, nonatomic) id <EventService> eventService;
@property (strong, nonatomic) id <PrototypeMapper> eventPrototypeMapper;

@end

