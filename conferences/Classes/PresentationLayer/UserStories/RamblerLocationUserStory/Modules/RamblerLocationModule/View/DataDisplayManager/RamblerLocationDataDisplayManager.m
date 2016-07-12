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

#import "RamblerLocationDataDisplayManager.h"

#import "DirectionCellObject.h"
#import "DirectionCellObjectFactory.h"

#import <Nimbus/NimbusCollections.h>

@interface RamblerLocationDataDisplayManager () <UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NICollectionViewModel *collectionModel;

@end

@implementation RamblerLocationDataDisplayManager

#pragma mark - Interface methods

- (id<UICollectionViewDataSource>)dataSourceForCollectionView:(UICollectionView *)collectionView
                                               withDirections:(NSArray<DirectionObject *> *)directions {
    NSArray *cellObjects = [self generateCellObjectsFromDirections:directions];
    self.collectionModel = [[NICollectionViewModel alloc] initWithListArray:cellObjects
                                                                   delegate:(id)[NICollectionViewCellFactory class]];
    return self.collectionModel;
}

- (id<UICollectionViewDelegate>)delegateForCollectionView:(UICollectionView *)collectionView {
    return self;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

#pragma mark - Private Methods

- (NSArray *)generateCellObjectsFromDirections:(NSArray <DirectionObject *> *)directions {
    NSMutableArray *mutableCellObjects = [NSMutableArray new];
    for (DirectionObject *direction in directions) {
        DirectionCellObject *cellObject = [self.cellObjectFactory createCellObjectWithObject:direction];
        [mutableCellObjects addObject:cellObject];
    }
    return [mutableCellObjects copy];
}

@end
