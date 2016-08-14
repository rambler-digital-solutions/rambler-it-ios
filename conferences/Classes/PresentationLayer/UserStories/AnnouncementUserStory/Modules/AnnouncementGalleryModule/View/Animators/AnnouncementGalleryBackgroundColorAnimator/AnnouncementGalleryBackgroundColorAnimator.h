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
#import <CoreGraphics/CoreGraphics.h>

@class UIColor;
@class UIView;
@class UIScrollView;
@class AnnouncementGalleryPageSizeCalculator;
@protocol AnnouncementGalleryBackgroundColorAnimatorDataSource;

/**
 @author Egor Tolstoy
 
 The object responsible for animating background color change
 */
@interface AnnouncementGalleryBackgroundColorAnimator : NSObject

@property (nonatomic, weak) UIView *view;
@property (nonatomic, weak) UIView *additionalView;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) id<AnnouncementGalleryBackgroundColorAnimatorDataSource> dataSource;
@property (nonatomic, strong) AnnouncementGalleryPageSizeCalculator *calculator;

/**
 @author Egor Tolstoy
 
 Method tells the animator that a scroll offset changed
 
 @param scrollOffset UICollectionView offset
 */
- (void)animateColorChangeWithScrollOffset:(CGFloat)scrollOffset;

@end

@protocol AnnouncementGalleryBackgroundColorAnimatorDataSource <NSObject>

/**
 @author Egor Tolstoy
 
 The method returns a color for a specific page
 
 @param pageNumber Page number
 
 @return UIColor
 */
- (UIColor *)obtainColorForPageWithNumber:(NSUInteger)pageNumber;

@end
