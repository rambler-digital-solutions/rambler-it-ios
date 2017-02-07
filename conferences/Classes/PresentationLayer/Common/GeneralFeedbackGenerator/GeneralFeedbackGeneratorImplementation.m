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

#import "GeneralFeedbackGeneratorImplementation.h"

#import "FeedbackGeneratorsFactoryImplementation.h"
#import "FeedbackGeneratorsFactory.h"
#import "ApplicationConstants.h"

#import <UIKit/UIKit.h>

@implementation GeneralFeedbackGeneratorImplementation

- (void)generateFeedbackWithType:(FeedbackType)feedbackType {
    if (IS_IOS_10_OR_LATER == NO) {
        return;
    }
    
    switch (feedbackType) {
        case FeedbackTypeSelection:
            [self generateSelectionFeedback];
            break;
        case FeedbackTypeLightImpact:
            [self generateLightImpactFeedback];
            break;
        case FeedbackTypeNotificationError:
            [self generateNotificationErrorFeedback];
            break;
        default:
            break;
    }
}

- (void)generateSelectionFeedback {
    UISelectionFeedbackGenerator *feedbackGenerator = [self.feedbackGeneratorsFactory selectionFeedbackGenerator];
    [feedbackGenerator prepare];
    [feedbackGenerator selectionChanged];
}

- (void)generateLightImpactFeedback {
    UIImpactFeedbackGenerator *feedbackGenerator = [self.feedbackGeneratorsFactory lightImpactFeedbackGenerator];
    [feedbackGenerator prepare];
    [feedbackGenerator impactOccurred];
}

- (void)generateNotificationErrorFeedback {
    UINotificationFeedbackGenerator *feedbackGenerator = [self.feedbackGeneratorsFactory notificationFeedbackGenerator];
    [feedbackGenerator prepare];
    [feedbackGenerator notificationOccurred:UINotificationFeedbackTypeError];
}

@end
