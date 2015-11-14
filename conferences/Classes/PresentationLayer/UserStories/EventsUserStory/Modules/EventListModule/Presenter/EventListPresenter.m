//
//  EventListPresenter.m
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "EventListPresenter.h"
#import "EventListViewInput.h"
#import "EventListInteractorInput.h"
#import "EventListRouterInput.h"
#import "PlainEvent.h"

@implementation EventListPresenter

#pragma mark - EventListViewOutput

- (void)setupView {
    NSArray *events = [self.interactor obtainEventList];
    [self.interactor updateEventList];
    [self.view setupViewWithEventList:events];
}

- (void)didTriggerTapCellWithEvent:(PlainEvent *)event {
    [self.router openEventModuleWithEventObjectId:event.objectId];
}

#pragma mark - EventListInteractorOutput

- (void)didUpdateEventList:(NSArray *)events {
    [self.view updateViewWithEventList:events];
}

@end