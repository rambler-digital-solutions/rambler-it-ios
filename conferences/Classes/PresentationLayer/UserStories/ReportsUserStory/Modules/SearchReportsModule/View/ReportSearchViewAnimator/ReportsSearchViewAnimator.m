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

#import "ReportsSearchViewAnimator.h"

static const CGFloat kTimeAnimationDuration = 0.2;

@implementation ReportsSearchViewAnimator

- (void)showClearPlaceholderWithAnimation {
    [self.clearPlaceholderView setHidden:NO];
    [self.reportsListSearchTableView setHidden:YES];
    [self.emptyPlaceholderView setHidden:YES];
    
    self.clearPlaceholderView.alpha = 0;
    
    [UIView animateWithDuration:kTimeAnimationDuration animations:^{
        self.clearPlaceholderView.alpha = 1;
    }];
}

- (void)closeSearchViewWithAnimation {
    if (self.containerView.alpha != 1) {
        return;
    }
    
    [UIView animateWithDuration:kTimeAnimationDuration animations:^{
        self.containerView.alpha = 0;
    } completion:^(BOOL finished) {
        self.containerView.alpha = 1;
        [self.reportsListSearchTableView setHidden:YES];
        [self.emptyPlaceholderView setHidden:YES];
        [self.clearPlaceholderView setHidden:YES];
        [self.delegate didTapClearPlaceholderView];
    }];
}

@end
