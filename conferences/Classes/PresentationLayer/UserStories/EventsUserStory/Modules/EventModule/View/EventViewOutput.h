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

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that view needs to be configuered
 */
- (void)setupView;

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that "sign up" button was tapped
 */
- (void)didTriggerSignUpButtonTappedEvent;

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that "save to calendar" button was tapped
 */
- (void)didTriggerSaveToCalendarButtonTappedEvent;

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that "read more" button of event description was tapped
 */
- (void)didTriggerReadMoreEventDescriptionButtonTappedEvent;

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that "read more" button of lecture description was tapped
 */
- (void)didTriggerReadMoreLectureDescriptionButtonTappedEvent;

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that "current translation" button was tapped
 */
- (void)didTriggerCurrentTranslationButtonTapEvent;

@end

