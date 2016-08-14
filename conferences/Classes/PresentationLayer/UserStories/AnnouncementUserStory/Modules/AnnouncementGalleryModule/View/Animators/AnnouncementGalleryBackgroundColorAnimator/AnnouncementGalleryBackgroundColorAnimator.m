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

#import "AnnouncementGalleryBackgroundColorAnimator.h"

#import "AnnouncementGalleryPageSizeCalculator.h"

#import <UIKit/UIKit.h>

static CGFloat const kThresholdCoefficient = 3;
static CGFloat const kAlphaOpacityBorder = 0.4;

@implementation AnnouncementGalleryBackgroundColorAnimator

#pragma mark - Public methods

/**
 @author Egor Tolstoy
 
 155, 465 - моменты переключения карт. Это pageWidth + pageWidth/2.
 55-255, 365-565 - это интервалы перехода цветов
 
 @param scrollOffset <#scrollOffset description#>
 */
- (void)animateColorChangeWithScrollOffset:(CGFloat)scrollOffset {
    CGFloat pageWidth = [self.calculator calculatePageSizeForViewWidth:self.view.frame.size.width];
    
    CGFloat initialThreshold = 100;
    
    // We are animating a situation, when we are in the middle of switching two cards
    CGFloat middleScreenOffset = scrollOffset + pageWidth / 2;
    
    NSInteger currentPageNumber = round(scrollOffset / pageWidth);
    NSLog(@"scrollOffset = %.f", scrollOffset);
    NSLog(@"middleScreenOffset = %.f", middleScreenOffset);
    NSLog(@"currentPageNumber = %lu", currentPageNumber);
    if (currentPageNumber < 0) {
        currentPageNumber = 0;
    }
    
    CGFloat delta = (NSInteger)middleScreenOffset % (NSInteger)pageWidth + pageWidth/2;
    NSLog(@"delta = %.f", delta);
    
    // We're interested in a range (-initialThreshold : initialThreshold). Wnen delta is out of this range, we just miss it.
    if (delta < -initialThreshold || delta > initialThreshold) {
        return;
    }

    NSInteger leftPageNumber = currentPageNumber - 1 > 0 ? currentPageNumber - 1 : 0;
    NSUInteger rightPageNumber = currentPageNumber;

    UIColor *leftColor = [self.dataSource obtainColorForPageWithNumber:leftPageNumber];
    UIColor *rightColor = [self.dataSource obtainColorForPageWithNumber:rightPageNumber];
    
    self.view.backgroundColor = leftColor;
    self.additionalView.backgroundColor = rightColor;
    
    // The opacity change should be non-linear.
    // We change it from 0.0 to alphaOpacityBorder on the interval of (-initialThreshold : alphaOffsetBorder).
    // And then we change it from alphaOpacityBorder to 1.0 on the interval of (alphaOffsetBorder : initialThreshold).
    CGFloat alphaOffsetBorder = initialThreshold / kThresholdCoefficient;
    if (delta < alphaOffsetBorder) {
        self.additionalView.alpha = ((delta + initialThreshold) / initialThreshold + alphaOffsetBorder) * kAlphaOpacityBorder;
    } else if (delta > alphaOffsetBorder) {
        self.additionalView.alpha = ((delta - alphaOffsetBorder) / alphaOffsetBorder) * (1.0 - kAlphaOpacityBorder) + kAlphaOpacityBorder;
    }
}

@end
