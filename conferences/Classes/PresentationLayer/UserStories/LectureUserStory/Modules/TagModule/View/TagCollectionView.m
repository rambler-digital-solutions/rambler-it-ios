//
// TagCollectionView.m
// LiveJournal
// 
// Created by Golovko Mikhail on 15/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TagCollectionView.h"
#import "TagViewOutput.h"
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

- (void)hideAddButton {
    [self.dataDisplayManager removeAddTagButton];
}

- (void)showAddButton {
    [self.dataDisplayManager appendAddTagButton];
}

- (void)enableRemoveTag {
    self.dataDisplayManager.enableRemoveTagButton = YES;
}

- (void)disableRemoveTag {
    self.dataDisplayManager.enableRemoveTagButton = NO;
}

- (void)removeTagAtIndex:(NSInteger)index {
    [self.dataDisplayManager removeTagAtIndex:index];
}

- (void)appendTagWithName:(NSString *)tagName {
    [self.dataDisplayManager appendTagWithName:tagName];
}

- (void)setupShowNumberOfLines:(NSInteger)lines {
    self.dataDisplayManager.numberOfShowLine = lines;
}

#pragma mark - Методы TagDataDisplayManagerDelegate

- (void)dataDisplayManagerDidTapAddButton:(TagDataDisplayManager *)dataDisplayManager {
    [self.output didTriggerTapAddButton];
}

- (void)dataDisplayManager:(TagDataDisplayManager *)dataDisplayManager
         didTapTagWithName:(NSString *)tagName {
    [self.output didTriggerTapTagWithName:tagName];
}

- (void)dataDisplayManager:(TagDataDisplayManager *)dataDisplayManager
   didTapRemoveTagWithName:(NSString *)tagName
                   atIndex:(NSInteger)index {
    [self.output didTriggerTapRemoveTagWithName:tagName atIndex:index];
}

#pragma mark - Методы TagModuleInput

- (void)configureModuleWithModuleConfig:(TagModuleConfig *)moduleConfig
                           moduleOutput:(id <TagModuleOutput>)moduleOutput {
    [self.moduleInput configureModuleWithModuleConfig:moduleConfig
                                         moduleOutput:moduleOutput];
}

- (void)addTagWithName:(NSString *)name {
    [self.moduleInput addTagWithName:name];
}

- (void)updateModuleWithSearchText:(NSString *)searchText {
    [self.moduleInput updateModuleWithSearchText:searchText];
}

@end