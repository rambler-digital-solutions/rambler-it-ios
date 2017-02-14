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

#import "RamblerLocationFeedbackGeneratorImplementation.h"
#import "LocationCardFlowLayoutConstants.h"
#import "GeneralFeedbackGenerator.h"

#import <UIKit/UIKit.h>

@implementation RamblerLocationFeedbackGeneratorImplementation

- (instancetype)init {
    self = [super init];
    if (self) {
        _currentPage = 1;
    }
    
    return self;
}

- (void)generateSelectionFeedbackInScrollView:(UIScrollView *)scrollView {
    CGFloat locationCardWidth = scrollView.frame.size.width - 2 * kLocationCardHorizontalInset;
    CGFloat actualScrollValue = scrollView.contentOffset.x + locationCardWidth - kLocationCardHorizontalInset / 2;
    if (scrollView.contentOffset.x < 0 || actualScrollValue > scrollView.contentSize.width) {
        return;
    }
    
    CGFloat delta = 2.5 * kLocationCardHorizontalInset;
    
    NSInteger newPageNumber = (scrollView.contentOffset.x + locationCardWidth - delta) / (locationCardWidth + kLocationCardHorizontalInset / 2) + 1;
    
    if (self.currentPage != newPageNumber) {
        self.currentPage = newPageNumber;
        [self.feedbackGenerator generateFeedbackWithType:TapticEngineFeedbackTypeSelection];
    }
}

@end
