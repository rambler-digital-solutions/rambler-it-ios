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