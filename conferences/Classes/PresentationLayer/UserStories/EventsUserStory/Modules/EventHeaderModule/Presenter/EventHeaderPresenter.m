//
//  EventHeaderPresenter.m
//  Conferences
//
//  Created by Karpushin Artem on 10/12/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "EventHeaderPresenter.h"
#import "EventHeaderViewInput.h"
#import "EventHeaderInteractorInput.h"
#import "EventHeaderRouterInput.h"

@interface EventHeaderPresenter()
@end

@implementation EventHeaderPresenter

#pragma mark - EventHeaderViewOutput

- (void)moduleReadyWithEvent:(PlainEvent *)event {
    [self.view configureViewWithEvent:event];
}

@end