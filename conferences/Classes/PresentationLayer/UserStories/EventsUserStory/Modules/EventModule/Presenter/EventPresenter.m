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
#import "PresenterCredentialsStorage.h"

@implementation EventPresenter

#pragma mark - EventModuleInput

- (void)configureCurrentModuleVithEvent:(PlainEvent *)event {
    self.presenterCredentialsStorage.event = event;
}

#pragma mark - EventViewOutput

- (void)setupView {
    PlainEvent *event = [PlainEvent new];
    event.name = @"Rambler.iOS #5";
    event.startDate = [NSDate date];
    event.eventDescription = @"Пришла осень, астрологи предсказали пору повышенной активности мобильных разработчиков - и 24 сентября мы готовы провести новую встречу Rambler.iOS официально под номером пять. Для тех, кто нас не помнит, небольшое вступление: мы — команда iOS-разработки холдинга Rambler&Co, любим делиться своими опытом и наработками с сообществом, поэтому организовали нерегулярные митапы для всех заинтересованных. Наше ключевое отличие от прочих кружков по интересам — мы уделяем большее внимание именно качеству выступлений, а не их количеству — все докладчики проходят через многоэтапную систему верификации и прослушивания — и на выходе получается действительно стоящий материал, ради которого не жалко потратить хмурый вечер четверга.";
    event.eventSubtitle = @"Очередная конференция посвященная iOS-разработке";
    self.presenterCredentialsStorage.event = event;
    [self.view configureViewWithEvent:self.presenterCredentialsStorage.event];
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

@end