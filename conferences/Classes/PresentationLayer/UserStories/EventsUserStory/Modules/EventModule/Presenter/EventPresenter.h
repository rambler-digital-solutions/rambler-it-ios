//
//  EventPresenter.h
//  Conferences
//
//  Created by Karpushin Artem on 01/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventViewOutput.h"
#import "EventInteractorOutput.h"
#import "EventModuleInput.h"

@protocol EventViewInput;
@protocol EventInteractorInput;
@protocol EventRouterInput;
@class EventPresenterStateStorage;

@interface EventPresenter : NSObject<EventModuleInput, EventViewOutput,EventInteractorOutput>

@property (nonatomic, weak) id<EventViewInput> view;
@property (nonatomic, strong) id<EventInteractorInput>  interactor;
@property (nonatomic, strong) id<EventRouterInput> router;
@property (nonatomic, strong) EventPresenterStateStorage *presenterStateStorage;

@end

