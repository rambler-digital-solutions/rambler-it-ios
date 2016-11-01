//
//  MessagesViewController.h
//  RamblerMessageExtension
//
//  Created by Trishina Ekaterina on 13/09/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Messages/Messages.h>
#import "EventListViewInput.h"
#import "EventListDataDisplayManager.h"

@class EventListDataDisplayManager, EventLaunchRouter, MessagesRouter;
@protocol EventService, ROSPonsomizer, ObjectTransformer, EventListViewOutput;
@protocol EventListRouterInput;

@interface MessagesViewController : MSMessagesAppViewController <EventListViewInput, EventListDataDisplayManagerDelegate>

@property (strong, nonatomic) id <EventService> eventService;
@property (strong, nonatomic) id <ROSPonsomizer> ponsomizer;

@property (nonatomic, strong) EventListDataDisplayManager *dataDisplayManager;
//@property (nonatomic, strong) EventLaunchRouter *router;
@property (nonatomic, strong) MessagesRouter *router;
@property (nonatomic, strong) id<ObjectTransformer> transformer;
@property (nonatomic, strong) id<EventListViewOutput> output;

@end
