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

#import "EventGalleryBackgroundColorAnimator.h"

#import "EventGalleryPageSizeCalculator.h"

#import <UIKit/UIKit.h>

static CGFloat const kThresholdCoefficient = 3;
static CGFloat const kAlphaOpacityBorder = 0.4;

@implementation EventGalleryBackgroundColorAnimator

#pragma mark - Public methods

- (void)animateColorChangeWithScrollOffset:(CGFloat)scrollOffset {
    if (scrollOffset < 0) {
        UIColor *leftColor = [self.dataSource obtainColorForPageWithNumber:0];
        self.view.backgroundColor = leftColor;
        self.additionalView.alpha = 0.;
        
        return;
    }
    
    CGFloat pageWidth = [self.calculator calculatePageSizeForViewWidth:self.view.frame.size.width];
    
    CGFloat initialThreshold = 100;
    
    // We are animating a situation, when we are in the middle of switching two cards
    CGFloat middleScreenOffset = scrollOffset + pageWidth / 2;
    NSInteger currentPageNumber = scrollOffset / pageWidth + 1;
    if (currentPageNumber < 0) {
        currentPageNumber = 0;
    }
    
    // delta is a distance from a central point between two cards. Can be negative and positive.
    CGFloat delta = (NSInteger)middleScreenOffset % (NSInteger)pageWidth;
    
    if (delta > pageWidth / 2) {
        delta -= pageWidth;
    }
    
    // We're interested in a range (-initialThreshold : initialThreshold). Wnen delta is out of this range, we just miss it.
    if (delta < -initialThreshold || delta > initialThreshold) {
        return;
    }
    
    NSInteger leftPageNumber = currentPageNumber - 1 > 0 ? currentPageNumber - 1 : 0;
    NSUInteger rightPageNumber = leftPageNumber + 1;
    
    UIColor *leftColor = [self.dataSource obtainColorForPageWithNumber:leftPageNumber];
    UIColor *rightColor = [self.dataSource obtainColorForPageWithNumber:rightPageNumber];
    
    self.view.backgroundColor = leftColor;
    self.additionalView.backgroundColor = rightColor;
    
    // The opacity change should be non-linear.
    // We change it from 0.0 to alphaOpacityBorder on the interval of (-initialThreshold : alphaOffsetBorder).
    // And then we change it from alphaOpacityBorder to 1.0 on the interval of (alphaOffsetBorder : initialThreshold).
    CGFloat alphaOffsetBorder = initialThreshold / kThresholdCoefficient;
    if (delta <= alphaOffsetBorder) {
        self.additionalView.alpha = ((delta + initialThreshold) / (initialThreshold + alphaOffsetBorder)) * kAlphaOpacityBorder;
    } else if (delta > alphaOffsetBorder) {
        self.additionalView.alpha = ((delta - alphaOffsetBorder) / alphaOffsetBorder) * (1.0 - kAlphaOpacityBorder) + kAlphaOpacityBorder;
    }
}

@end
