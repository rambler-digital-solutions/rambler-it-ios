//
//  EventListPresenter.h
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventListViewOutput.h"
#import "EventListInteractorOutput.h"

@protocol EventListViewInput;
@protocol EventListInteractorInput;
@protocol EventListRouterInput;

@interface EventListPresenter : NSObject<EventListViewOutput,EventListInteractorOutput>

@property (nonatomic, weak) id<EventListViewInput> view;
@property (nonatomic, strong) id<EventListInteractorInput>  interactor;
@property (nonatomic, strong) id<EventListRouterInput> router;

@end

