//
//  EventPresenter.m
//  Conferences
//
//  Created by Karpushin Artem on 01/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "EventPresenter.h"
#import "EventViewInput.h"
#import "EventInteractorInput.h"
#import "EventRouterInput.h"
#import "PlainEvent.h"

@interface EventPresenter()

@property (strong, nonatomic) PlainEvent *event;

@end

@implementation EventPresenter

#pragma mark - EventViewOutput

- (void)setupView {
    PlainEvent *event = [PlainEvent new];
    event.name = @"Rambler.iOS #5";
    [self.view configureViewWithEvent:event];
}

#pragma mark - EventInteractorOutput

@end