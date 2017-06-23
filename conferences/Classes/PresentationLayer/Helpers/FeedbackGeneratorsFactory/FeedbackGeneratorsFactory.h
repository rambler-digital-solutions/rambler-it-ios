// Copyright (c) 2017 RAMBLER&Co
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

@class UINotificationFeedbackGenerator;
@class UISelectionFeedbackGenerator;
@class UIImpactFeedbackGenerator;

/**
 @author Surik Sarkisyan
 
 Factory for creating instances of UIFeedbackGenerator
 */
@protocol FeedbackGeneratorsFactory <NSObject>

/**
 @author Surik Sarkisyan
 
 Method returns selection feedback generator
 
 @return UISelectionFeedbackGenerator
 */
- (UISelectionFeedbackGenerator *)selectionFeedbackGenerator;

/**
 @author Surik Sarkisyan
 
 Method returns light impact feedback generator
 
 @return UIImpactFeedbackGenerator
 */
- (UIImpactFeedbackGenerator *)lightImpactFeedbackGenerator;

/**
 @author Surik Sarkisyan
 
 Method returns notification feedback generator
 
 @return UINotificationFeedbackGenerator
 */
- (UINotificationFeedbackGenerator *)notificationFeedbackGenerator;

@end
