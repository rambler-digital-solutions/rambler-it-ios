//
//  EventHeaderPresenter.h
//  Conferences
//
//  Created by Karpushin Artem on 10/12/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventHeaderViewOutput.h"
#import "EventHeaderInteractorOutput.h"

@protocol EventHeaderViewInput;
@protocol EventHeaderInteractorInput;
@protocol EventHeaderRouterInput;

@interface EventHeaderPresenter : NSObject<EventHeaderViewOutput,EventHeaderInteractorOutput>

@property (nonatomic, weak) id<EventHeaderViewInput> view;
@property (nonatomic, strong) id<EventHeaderInteractorInput>  interactor;
@property (nonatomic, strong) id<EventHeaderRouterInput> router;

@end

