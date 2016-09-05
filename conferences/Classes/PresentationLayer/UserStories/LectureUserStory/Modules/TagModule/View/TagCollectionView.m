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

#import "TagCollectionView.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "TagModuleInput.h"
#import "TagCellSizeConfig.h"


@implementation TagCollectionView

+ (TagCollectionView *)collectionView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                          owner:self
                                        options:NULL] firstObject];
}

- (void)setContentSize:(CGSize)contentSize {
    [super setContentSize:contentSize];
    [self invalidateIntrinsicContentSize];
}

- (CGSize)intrinsicContentSize {
    return self.contentSize;
}

#pragma mark - Методы TagViewInput

- (void)setupInitialState {
    id <UICollectionViewDelegate> delegate = [self.dataDisplayManager delegateForCollectionView:self];
    self.delegate = delegate;
}

- (void)showTags:(NSArray *)tags {
    id <UICollectionViewDataSource> dataSource = [self.dataDisplayManager dataSourceForCollectionView:self
                                                                                             withTags:tags];
    self.dataSource = dataSource;
    [self reloadData];

    self.contentOffset = CGPointZero;
}

- (void)setupVerticalContentAlign {
    UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
    layout.minimumInteritemSpacing = self.cellSizeConfig.itemSpacing;
    layout.minimumLineSpacing = self.cellSizeConfig.itemSpacing;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;

    self.collectionViewLayout = layout;
    self.scrollEnabled = NO;
    self.alwaysBounceHorizontal = NO;
    self.showsVerticalScrollIndicator = NO;

    [self.dataDisplayManager setCompressWidth:YES];
}

- (void)setupHorizontalContentAlign {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = self.cellSizeConfig.itemSpacing;
    layout.minimumLineSpacing = self.cellSizeConfig.itemSpacing;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self.collectionViewLayout = layout;
    self.scrollEnabled = YES;
    self.alwaysBounceHorizontal = YES;
    self.showsHorizontalScrollIndicator = NO;

    [self.dataDisplayManager setCompressWidth:NO];
}

#pragma mark - Методы TagModuleInput

- (void)configureModuleWithModuleConfig:(TagModuleConfig *)moduleConfig
                           moduleOutput:(id <TagModuleOutput>)moduleOutput {
    [self.moduleInput configureModuleWithModuleConfig:moduleConfig
                                         moduleOutput:moduleOutput];
}

- (void)setupShowNumberOfLines:(NSInteger)lines {
    self.dataDisplayManager.numberOfShowLine = lines;
}



@end