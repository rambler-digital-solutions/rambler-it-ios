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

#import "EventViewAnimator.h"
#import "EventHeaderView.h"

static CGFloat const kEventTopConstraintConstant = 0.0;
static CGFloat const kAnnouncementImageMaxScaleConstant = 2.0;
static CGFloat const kAnnouncementImageMinScaleConstant = 1.0;

@implementation EventViewAnimator

- (void)animateWithContentOffset:(CGPoint)contentOffset {
    CGFloat offset = contentOffset.y;
    if (offset < 0) {
        self.headerView.topConstraint.constant = kEventTopConstraintConstant + contentOffset.y;
        CGFloat height = self.headerView.bounds.size.height;
        CGFloat scale = -offset / height * (kAnnouncementImageMaxScaleConstant -kAnnouncementImageMinScaleConstant) + kAnnouncementImageMinScaleConstant;
        CGFloat normalizeScale = MIN(scale, kAnnouncementImageMaxScaleConstant);
        self.headerView.eventImageView.transform = CGAffineTransformMakeScale(normalizeScale, normalizeScale);
    }
    
    self.tableView.clipsToBounds = offset > self.headerView.bounds.size.height;
}

@end
