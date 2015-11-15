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
#import "PresenterStateStorage.h"

@implementation EventPresenter

#pragma mark - EventModuleInput

- (void)configureCurrentModuleWithEventObjectId:(NSString *)objectId {
    self.presenterStateStorage.eventObjectId = objectId;
}

#pragma mark - EventViewOutput

- (void)setupView {
    // по непонятной причине configureCurrentModuleWithEventObjectId вызывется после setupView
    PlainEvent *event = [self.interactor obtainEventByObjectId:@"aa02cRQdpw"];

    [self.view configureViewWithEvent:event];
}

- (void)didTriggerSignUpButtonTappedEvent:(id)button {
    
}

- (void)didTriggerSaveToCalendarButtonTappedEvent:(id)button {
    
}

- (void)didTriggerReadMoreEventDescriptionButtonTappedEvent:(id)button {
    
}

- (void)didTriggerReadMoreLectionDescriptionButtonTappedEvent:(id)button {
    
}

- (void)didTriggerCurrentTranslationButtonTapEvent:(UIButton *)button {
    
}

@end