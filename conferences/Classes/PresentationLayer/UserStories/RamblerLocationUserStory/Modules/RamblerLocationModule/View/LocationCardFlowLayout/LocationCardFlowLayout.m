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

#import "LocationCardFlowLayout.h"

#import "LocationCardFlowLayoutConstants.h"

@implementation LocationCardFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    CGFloat locationCardWidth = self.collectionView.frame.size.width - 2 * kLocationCardHorizontalInset;
    CGFloat locationCardHeigth = self.collectionView.frame.size.height - 2 * kLocationCardVerticalInset;
    self.itemSize = CGSizeMake(locationCardWidth,
                               locationCardHeigth);
    
    self.minimumLineSpacing = kLocationCardHorizontalInset / 2;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0.0,
                                         kLocationCardHorizontalInset,
                                         0.0,
                                         kLocationCardHorizontalInset);
}

- (CGFloat)pageWidth {
    return self.itemSize.width + self.minimumLineSpacing;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
                                 withScrollingVelocity:(CGPoint)velocity {
    CGFloat rawPageValue = self.collectionView.contentOffset.x / self.pageWidth;
    CGFloat currentPage = (velocity.x > 0.0) ? floor(rawPageValue) : ceil(rawPageValue);
    CGFloat nextPage = (velocity.x > 0.0) ? ceil(rawPageValue) : floor(rawPageValue);
    
    BOOL pannedLessThanAPage = fabs(1 + currentPage - rawPageValue) > 0.5;
    BOOL flicked = fabs(velocity.x) > [self flickVelocity];
    if (pannedLessThanAPage && flicked) {
        proposedContentOffset.x = nextPage * self.pageWidth;
    } else {
        proposedContentOffset.x = round(rawPageValue) * self.pageWidth;
    }
    
    return proposedContentOffset;
}

- (CGFloat)flickVelocity {
    return kLocationCardFlickVelocity;
}

@end
