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
#import "TagButtonCollectionViewCellObject.h"
#import "CollectionViewAnimator.h"
#import "NIMutableCollectionViewModel.h"
#import "NICollectionViewActions.h"
#import "NIMutableCollectionViewModel+LJAddObject.h"
#import "TagModuleViewConstants.h"
#import <libextobjc/EXTScope.h>

const NSInteger kUndefineSectionIndex = -1;
const CGFloat kTagSectionTopInset = 5.0f;
const NSInteger kMaxCountItemsCollapseFromCalculate = 99;

static NSString *const kTagMoreButton = @"%lu ещё";
static NSString *const kTagViewAddTagButton = @"Добавить метку";

typedef NS_ENUM(NSInteger, TagSectionIndex) {
    TagItemSectionIndex = 0,
    TagAddButtonSectionIndex = 1
};

@interface TagDataDisplayManager ()

@property (nonatomic, strong) NIMutableCollectionViewModel *collectionViewModule;
@property (nonatomic, strong) NICollectionViewActions *collectionViewActions;
@property (nonatomic, strong) CollectionViewAnimator *collectionViewAnimator;
@property (nonatomic, assign) NSInteger addButtonSectionIndex;
@property (nonatomic, strong) NSArray *hideTags;

@end

@implementation TagDataDisplayManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _addButtonSectionIndex = kUndefineSectionIndex;
        [self setupActions];
    }

    return self;
}

- (void)setupActions {
    self.collectionViewActions = [[NICollectionViewActions alloc] initWithTarget:self];

    @weakify(self);
    
    NIActionBlock addTagTapBlock = ^BOOL(TagButtonCollectionViewCellObject *object, id target, NSIndexPath *indexPath) {
        @strongify(self);
        switch(object.type) {
            case TagButtonMoreType:
                [self didTapMoreButton:object];
                break;
            case TagButtonAddTagType:
                [self.delegate dataDisplayManagerDidTapAddButton:self];
                break;
            default:
                break;
        }
        return NO;
    };
    [self.collectionViewActions attachToClass:[TagButtonCollectionViewCellObject class]
                                     tapBlock:addTagTapBlock];

    NIActionBlock tagTapBlock = ^BOOL(TagCollectionViewCellObject *tagCellObject, id target, NSIndexPath *indexPath) {
        @strongify(self);
        [self.delegate dataDisplayManager:self
                        didTapTagWithName:tagCellObject.tagName];
        return NO;
    };
    [self.collectionViewActions attachToClass:[TagCollectionViewCellObject class]
                                     tapBlock:tagTapBlock];
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
    self.collectionViewAnimator = [CollectionViewAnimator animatorWithCollectionView:collectionView];

    return self.collectionViewModule;
}

- (void)appendAddTagButton {
    /**
     @author Golovko Mikhail
     
     Если кнопка уже добавленна, то добавлять ещё раз не надо.
     */
    if (self.addButtonSectionIndex != kUndefineSectionIndex) {
        return;
    }
    
    /**
     @author Golovko Mikhail
     
     Если модели нету, то и добавлять некуда. Поэтому поменяем индекс секции на дефолтный
     для кнопки Add Button. Тогда при создании модели добавится кнопка.
     */
    if (self.collectionViewModule == nil) {
        self.addButtonSectionIndex = TagAddButtonSectionIndex;
        return;
    }

    NSIndexSet *addIndexSet = [self.collectionViewModule addSectionWithTitle:@""];
    self.addButtonSectionIndex = addIndexSet.firstIndex;
    TagButtonCollectionViewCellObject *cellObject = [self createAddButtonObject];
    [self.collectionViewModule addObject:cellObject
                               toSection:self.addButtonSectionIndex];

    [self.collectionViewAnimator animateTableViewWithInsertedSectionsIndexSet:addIndexSet
                                                      updatedSectionsIndexSet:nil
                                                      removedSectionsIndexSet:nil
                                                                 batchUpdates:YES];
}

- (void)removeAddTagButton {
    /**
     @author Golovko Mikhail
     
     Если кнопка не добавлена, то удалять нечего.
     */
    if (self.addButtonSectionIndex == kUndefineSectionIndex) {
        return;
    }

    /**
     @author Golovko Mikhail
     
     Если модели нет, то удалять неоткуда. Просто сбрасываем индекс, чтобы при
     создании модели кнопка не добавилась.
     */
    if (self.collectionViewModule == nil) {
        self.addButtonSectionIndex = kUndefineSectionIndex;
        return;
    }

    [self.collectionViewModule removeSectionAtIndex:self.addButtonSectionIndex];

    NSIndexSet *removeIndexSet = [[NSIndexSet alloc] initWithIndex:self.addButtonSectionIndex];

    [self.collectionViewAnimator animateTableViewWithInsertedSectionsIndexSet:nil
                                                      updatedSectionsIndexSet:nil
                                                      removedSectionsIndexSet:removeIndexSet
                                                                 batchUpdates:YES];

    self.addButtonSectionIndex = kUndefineSectionIndex;
}

- (void)setCompressWidth:(BOOL)compressWidth {
    self.cellSizeCalculator.compressWidth = compressWidth;
}

- (BOOL)compressWidth {
    return self.cellSizeCalculator.compressWidth;
}


- (void)removeTagAtIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index
                                                inSection:TagItemSectionIndex];

    [self.collectionViewModule removeObjectAtIndexPath:indexPath];
    [self.collectionViewAnimator animateTableViewWithInsertedItemsAtIndexPaths:nil
                                                        updatedItemsIndexPaths:nil
                                                        removedItemsIndexPaths:@[indexPath]
                                                                  batchUpdates:YES];
}

- (void)appendTagWithName:(NSString *)tagName {
    id object = [self createTagCellWithName:tagName];
    NSArray *insertedIndexPaths = [self.collectionViewModule addObject:object
                                                             toSection:TagItemSectionIndex];
    [self.collectionViewAnimator animateTableViewWithInsertedItemsAtIndexPaths:insertedIndexPaths
                                                        updatedItemsIndexPaths:nil
                                                        removedItemsIndexPaths:nil
                                                                  batchUpdates:YES];
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

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.collectionViewActions collectionView:collectionView
                      didSelectItemAtIndexPath:indexPath];
}

#pragma mark - методы TagCellDelegate

- (void)didTapRemoveTag:(TagCollectionViewCellObject *)cellObject {
    NSIndexPath *indexPath = [self.collectionViewModule indexPathForObject:cellObject];
    [self.delegate dataDisplayManager:self
              didTapRemoveTagWithName:cellObject.tagName
                              atIndex:indexPath.row];
}

#pragma mark - Дополнительные методы

- (void)didTapMoreButton:(TagButtonCollectionViewCellObject *)cellObject {
    NSIndexPath *removeIndexPath = [self.collectionViewModule indexPathForObject:cellObject];
    [self.collectionViewModule removeObjectAtIndexPath:removeIndexPath];

    NSArray *insertIndexPaths = [self.collectionViewModule addObjectsFromArray:self.hideTags
                                                                     toSection:TagItemSectionIndex];

    [self.collectionViewAnimator animateTableViewWithInsertedItemsAtIndexPaths:insertIndexPaths
                                                        updatedItemsIndexPaths:nil
                                                        removedItemsIndexPaths:@[removeIndexPath]
                                                                  batchUpdates:YES];

}

#pragma mark - Методы генерации объектов ячеек

- (NSArray *)generateCellObjects:(NSArray *)tags {
    NSMutableArray *tagObjects = [NSMutableArray array];
    [tagObjects addObject:@""];

    [tagObjects addObjectsFromArray:[self generateTagContentCellObjects:tags]];

    if (self.addButtonSectionIndex != kUndefineSectionIndex) {
        [tagObjects addObject:@""];
        TagButtonCollectionViewCellObject *cellObject = [self createAddButtonObject];
        [tagObjects addObject:cellObject];

    }

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

    TagButtonCollectionViewCellObject *lastTemplateCellObject = [self createMoreButtonWithCount:kMaxCountItemsCollapseFromCalculate];

    NSInteger countTags = [self.cellSizeCalculator countItemsInRows:self.numberOfShowLine
                                                     forCellObjects:tagObjects
                                                     lastCellObject:lastTemplateCellObject];

    NSMutableArray *showObjects = [NSMutableArray array];
    NSArray *showTags = [tagObjects subarrayWithRange:NSMakeRange(0, countTags)];
    [showObjects addObjectsFromArray:showTags];

    self.hideTags = [tagObjects subarrayWithRange:NSMakeRange(countTags, tagObjects.count - countTags)];

    TagButtonCollectionViewCellObject *lastCellObject = [self createMoreButtonWithCount:self.hideTags.count];

    [showObjects addObject:lastCellObject];

    return [showObjects copy];
}

#pragma mark - Методы создания объектов ячеек

- (TagButtonCollectionViewCellObject *)createAddButtonObject {
    TagButtonCollectionViewCellObject *cellObject = [[TagButtonCollectionViewCellObject alloc] initWithTextButton:kTagViewAddTagButton
                                                                                                             type:TagButtonAddTagType];
    return cellObject;
}

- (TagCollectionViewCellObject *)createTagCellWithName:(NSString *)tagName {
    TagCollectionViewCellObject *object = [[TagCollectionViewCellObject alloc] initWithTagName:tagName
                                                                            enableRemoveButton:self.enableRemoveTagButton
                                                                                      delegate:self];
    return object;
}

- (TagButtonCollectionViewCellObject *)createMoreButtonWithCount:(NSInteger)count {
    NSString *textButton = [[NSString alloc] initWithFormat:kTagMoreButton, (long)count];
    TagButtonCollectionViewCellObject *cellObject = [[TagButtonCollectionViewCellObject alloc] initWithTextButton:textButton
                                                                                                             type:TagButtonMoreType];
    return cellObject;
}

@end