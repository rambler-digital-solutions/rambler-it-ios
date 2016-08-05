//
// CollectionViewAnimator.m
// LiveJournal
// 
// Created by Golovko Mikhail on 17/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "CollectionViewAnimator.h"


@implementation CollectionViewAnimator
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    self = [super init];
    if (self) {
        _collectionView = collectionView;
    }

    return self;
}

+ (instancetype)animatorWithCollectionView:(UICollectionView *)collectionView {
    return [[self alloc] initWithCollectionView:collectionView];
}

- (void)animateTableViewWithInsertedSectionsIndexSet:(NSIndexSet *)insertedSectionsIndexSet
                             updatedSectionsIndexSet:(NSIndexSet *)updatedSectionsIndexSet
                             removedSectionsIndexSet:(NSIndexSet *)removedSectionsIndexSet
                                        batchUpdates:(BOOL)isBatchUpdate {

    void (^updateBlock)() = ^{
        if (insertedSectionsIndexSet) {
            [self.collectionView insertSections:insertedSectionsIndexSet];
        }

        if (removedSectionsIndexSet) {
            [self.collectionView deleteSections:removedSectionsIndexSet];
        }

        if (updatedSectionsIndexSet) {
            [self.collectionView reloadSections:updatedSectionsIndexSet];
        }
    };

    if (isBatchUpdate) {
        [self.collectionView performBatchUpdates:updateBlock completion:nil];
    }
    else {
        updateBlock();
    }
}


- (void)animateTableViewWithInsertedItemsAtIndexPaths:(NSArray *)insertedItemsAtIndexPaths
                               updatedItemsIndexPaths:(NSArray *)updatedItemsAtIndexPaths
                               removedItemsIndexPaths:(NSArray *)removedItemsAtIndexPaths
                                         batchUpdates:(BOOL)isBatchUpdate {
    void (^updateBlock)() = ^{
        if (insertedItemsAtIndexPaths) {
            [self.collectionView insertItemsAtIndexPaths:insertedItemsAtIndexPaths];
        }

        if (removedItemsAtIndexPaths) {
            [self.collectionView deleteItemsAtIndexPaths:removedItemsAtIndexPaths];
        }

        if (updatedItemsAtIndexPaths) {
            [self.collectionView reloadItemsAtIndexPaths:updatedItemsAtIndexPaths];
        }
    };

    if (isBatchUpdate) {
        [self.collectionView performBatchUpdates:updateBlock completion:nil];
    }
    else {
        updateBlock();
    }
}


@end