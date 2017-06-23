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

#import "TagDataDisplayManager.h"
#import "TagCollectionViewCellObject.h"
#import "TagCellSizeCalculator.h"
#import "CollectionViewAnimator.h"
#import "NIMutableCollectionViewModel.h"
#import "NICollectionViewActions.h"
#import "NIMutableCollectionViewModel+LJAddObject.h"
#import "TagModuleViewConstants.h"
#import <libextobjc/EXTScope.h>

const NSInteger kUndefineSectionIndex = -1;
const CGFloat kTagSectionTopInset = 5.0f;

typedef NS_ENUM(NSInteger, TagSectionIndex) {
    TagItemSectionIndex = 0,
    TagAddButtonSectionIndex = 1
};

@interface TagDataDisplayManager ()

@property (nonatomic, strong) NIMutableCollectionViewModel *collectionViewModule;

@end

@implementation TagDataDisplayManager

- (instancetype)init {
    self = [super init];
    if (self) {
    }

    return self;
}

#pragma mark - Методы интерфейса

- (id <UICollectionViewDelegate>)delegateForCollectionView:(UICollectionView *)collectionView {
    return self;
}

- (id <UICollectionViewDataSource>)dataSourceForCollectionView:(UICollectionView *)collectionView
                                                      withTags:(NSArray *)tags {
    
    NSArray *cellObjects = [self generateCellObjects:tags];
    self.collectionViewModule = [[NIMutableCollectionViewModel alloc] initWithSectionedArray:cellObjects
                                                             delegate:(id)[NICollectionViewCellFactory class]];
    return self.collectionViewModule;
}

#pragma mark - Методы UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    id cellObject = [self.collectionViewModule objectAtIndexPath:indexPath];
    return [self.cellSizeCalculator sizeForCellObject:cellObject];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    if (section == TagItemSectionIndex) {
        return UIEdgeInsetsZero;
    }
    return UIEdgeInsetsMake(kTagSectionTopInset, 0, 0, 0);
}

#pragma mark - Методы генерации объектов ячеек

- (NSArray *)generateCellObjects:(NSArray *)tags {
    NSMutableArray *tagObjects = [NSMutableArray array];
    [tagObjects addObject:@""];

    [tagObjects addObjectsFromArray:[self generateTagContentCellObjects:tags]];

    return tagObjects;
}


- (NSArray *)generateTagContentCellObjects:(NSArray *)tags {
    NSMutableArray *tagObjects = [NSMutableArray array];
    for (NSString *tag in tags) {
        id object = [self createTagCellWithName:tag];
        [tagObjects addObject:object];
    }
    
    if (self.numberOfShowLine != TagModuleDisableCollapseTags) {
        return [self collapseTagCellObjects:tagObjects];
    }
    return [tagObjects copy];
}

- (NSArray *)collapseTagCellObjects:(NSArray *)tagObjects {
    NSInteger numberFullRows = [self.cellSizeCalculator countRowsForObjects:tagObjects];
    if (numberFullRows <= self.numberOfShowLine) {
        return tagObjects;
    }
    
    NSInteger countTags = [self.cellSizeCalculator countItemsInRows:self.numberOfShowLine
                                                     forCellObjects:tagObjects];

    NSMutableArray *showObjects = [NSMutableArray array];
    NSArray *showTags = [tagObjects subarrayWithRange:NSMakeRange(0, countTags)];
    [showObjects addObjectsFromArray:showTags];

    return [showObjects copy];
}

#pragma mark - Методы создания объектов ячеек

- (TagCollectionViewCellObject *)createTagCellWithName:(NSString *)tagName {
    TagCollectionViewCellObject *object = [[TagCollectionViewCellObject alloc] initWithTagName:tagName];
    return object;
}

- (CGFloat)obtainHeightTagCollectionViewWithTags:(NSArray *)tags {
    NSArray *cellObjects = [self generateTagContentCellObjects:tags];
    CGFloat height = [self.cellSizeCalculator calculateHeightRowsForCellObjects:cellObjects];
    return height;
}

@end