// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

@class UIButton;
@class EventPlainObject;

@protocol EventViewOutput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that view needs to be configuered
 */
- (void)didTriggerViewReadyEvent;

/**
 @author Egor TOlstoy
 
 Method is used to inform presenter that view will disappear
 */
- (void)didTriggerViewWillDisappearEvent;

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that "sign up" button was tapped
 */
- (void)didTapSignUpButtonWithEvent:(EventPlainObject *)event;

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that "save to calendar" button was tapped
 */
- (void)didTapSaveToCalendarButtonWithEvent:(EventPlainObject *)event;

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that cell with lecture info was tapped
 
 @param lectureObjectId Lecture objectId
 */
- (void)didTapLectureInfoCellWithLectureObjectIdEvent:(NSString *)lectureObjectId;

/**
 @author Egor Tolstoy
 
 Method is used to inform presenter that cell with event info was tapped
 
 @param eventId Event identifier
 */
- (void)didTapEventCellWithEventId:(NSString *)eventId;

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that share button was tapped
 */
- (void)didTapShareButton;

/**
 @author Vasyura Anastasiya
 
 Method is used to inform presenter that speaker view was tapped
 */
- (void)didTapSpeakerViewWithSpeakerId:(NSString *)speakerId;

@end

