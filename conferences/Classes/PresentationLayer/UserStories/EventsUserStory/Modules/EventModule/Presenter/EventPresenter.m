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
    PlainEvent *event = [self.interactor obtainEventByObjectId:self.presenterStateStorage.eventObjectId];
    [self.interactor updateEventByObjectId:self.presenterStateStorage.eventObjectId];
    
    PlainEvent *testEvent = [PlainEvent new];
    event.name = @"Rambler.iOS #5";
    event.startDate = [NSDate date];
    event.eventDescription = @"Пришла осень, астрологи предсказали пору повышенной активности мобильных разработчиков - и 24 сентября мы готовы провести новую встречу Rambler.iOS официально под номером пять. Для тех, кто нас не помнит, небольшое вступление: мы — команда iOS-разработки холдинга Rambler&Co, любим делиться своими опытом и наработками с сообществом, поэтому организовали нерегулярные митапы для всех заинтересованных. Наше ключевое отличие от прочих кружков по интересам — мы уделяем большее внимание именно качеству выступлений, а не их количеству — все докладчики проходят через многоэтапную систему верификации и прослушивания — и на выходе получается действительно стоящий материал, ради которого не жалко потратить хмурый вечер четверга.";
    event.eventSubtitle = @"Очередная конференция посвященная iOS-разработке";

    [self.view configureViewWithEvent:testEvent];
}

- (void)didTriggerSignUpButtonTappedEvent:(id)button {
    
}

- (void)didTriggerSaveToCalendarButtonTappedEvent:(id)button {
    
}

- (void)didTriggerReadMoreEventDescriptionButtonTappedEvent:(id)button {
    
}

- (void)didTriggerReadMoreLectionDescriptionButtonTappedEvent:(id)button {
    
}

#pragma mark - EventInteractorOutput

- (void)didUpdateEvent:(PlainEvent *)event {
    
}

@end