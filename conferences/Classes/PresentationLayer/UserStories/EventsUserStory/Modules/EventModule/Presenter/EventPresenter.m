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
#import "EventPresenterStateStorage.h"

@implementation EventPresenter

#pragma mark - EventModuleInput

- (void)configureCurrentModuleWithEventObjectId:(NSString *)objectId {
    self.presenterStateStorage.eventObjectId = objectId;
}

#pragma mark - EventViewOutput

- (void)setupView {
    [self.interactor obtainEventByObjectId:self.presenterStateStorage.eventObjectId];
}

- (void)didTriggerSignUpButtonTappedEvent {
    
}

- (void)didTriggerSaveToCalendarButtonTappedEvent {
    
}

- (void)didTriggerReadMoreEventDescriptionButtonTappedEvent {
    
}

- (void)didTriggerReadMoreLectureDescriptionButtonTappedEvent {
    
}

- (void)didTriggerCurrentTranslationButtonTapEvent {
    
}

#pragma mark - EventInteractorOutput

- (void)didObtainEvent:(PlainEvent *)event {
    [self.view configureViewWithEvent:event];
}

@end