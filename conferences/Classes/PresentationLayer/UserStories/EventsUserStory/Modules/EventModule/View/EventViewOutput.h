//
//  EventViewOutput.h
//  Conferences
//
//  Created by Karpushin Artem on 01/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//
#import <Foundation/Foundation.h>

@class UIButton;

@protocol EventViewOutput <NSObject>

- (void)setupView;
- (void)didTriggerSignUpButtonTappedEvent:(UIButton *)button;
- (void)didTriggerSaveToCalendarButtonTappedEvent:(UIButton *)button;
- (void)didTriggerReadMoreEventDescriptionButtonTappedEvent:(UIButton *)button;
- (void)didTriggerReadMoreLectionDescriptionButtonTappedEvent:(UIButton *)button;
- (void)didTriggerCurrentTranslationButtonTapEvent:(UIButton *)button;

@end

