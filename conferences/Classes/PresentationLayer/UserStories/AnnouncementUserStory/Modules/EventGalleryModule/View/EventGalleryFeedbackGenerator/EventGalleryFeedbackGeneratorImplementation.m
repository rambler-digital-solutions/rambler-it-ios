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

#import "EventGalleryFeedbackGeneratorImplementation.h"

#import "EventGalleryPageSizeCalculator.h"

#import <UIKit/UIKit.h>

@implementation EventGalleryFeedbackGeneratorImplementation

- (instancetype)init {
    self = [super init];
    if (self) {
        _currentPage = 1;
    }
    
    return self;
}

- (void)generateSelectionFeedbackForContentOffset:(CGFloat)contentOffsetX
                                           inView:(UICollectionView *)collectionView {
    CGFloat pageWidth = [self.calculator calculatePageSizeForViewWidth:collectionView.frame.size.width];
    if (contentOffsetX < 0 || contentOffsetX + pageWidth > collectionView.contentSize.width) {
        return;
    }
    
    [self.selectionFeedbackGenerator prepare];
    
    NSInteger newPageNumber = (contentOffsetX + pageWidth / 2) / pageWidth + 1;
    
    if (self.currentPage != newPageNumber) {
        self.currentPage = newPageNumber;
        [self.selectionFeedbackGenerator selectionChanged];
    }
}

- (void)generateNotificationErrorFeedback {
    [self.notificationFeedbackGenerator prepare];
    [self.notificationFeedbackGenerator notificationOccurred:UINotificationFeedbackTypeError];
}

@end
