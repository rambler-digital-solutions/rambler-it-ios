//
// TagCellSizeCalculator.m
// LiveJournal
// 
// Created by Golovko Mikhail on 17/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TagCellSizeCalculator.h"
#import "TagCellSizeConfig.h"
#import "NICollectionViewCellFactory.h"
#import "TagCellSizeRowCalculator.h"


@interface TagCellSizeCalculator ()

@property (nonatomic, strong) NSMutableDictionary *prototypeCells;

@end


@implementation TagCellSizeCalculator

#pragma mark - Методы интерфейса

- (instancetype)initWithRowCalculator:(TagCellSizeRowCalculator *)rowCalculator
                               config:(TagCellSizeConfig *)config {
    self = [super init];
    if (self) {
        _rowCalculator = rowCalculator;
        _config = config;
    }

    return self;
}

- (CGSize)sizeForCellObject:(id <NICollectionViewNibCellObject>)cellObject {
    CGSize size = [self fullSizeForCellObject:cellObject];

    if (self.compressWidth) {
        size = [self compressingCellSize:size];
    }

    return size;
}

- (NSInteger)countItemsInRows:(NSInteger)rows
               forCellObjects:(NSArray *)cellObjects
               lastCellObject:(id <NICollectionViewNibCellObject>)lastCellObject {

    [self.rowCalculator cleanRows];

    /**
     @author Golovko Mikhail
     
     Индекс добавляемой ячейки.
     */
    NSUInteger cellObjectIndex = 0;

    for (int i = 0; i < rows; ++i) {

        [self.rowCalculator addNewRow];

        /**
         @author Golovko Mikhail
         
         Если последняя строка, первым делом добавляем последний cellobject, 
         который обязательно должен быть.
         */
        if (i == rows - 1) {
            CGSize size = [self sizeForCellObject:lastCellObject];

            [self.rowCalculator addItemInSameRowAtWidth:size.width];
        }

        while(cellObjectIndex < cellObjects.count) {

            id <NICollectionViewNibCellObject> cellObject = cellObjects[cellObjectIndex];

            CGSize size = [self sizeForCellObject:cellObject];

            if (![self.rowCalculator addItemInSameRowAtWidth:size.width]) {
                /**
                 @author Golovko Mikhail
                 
                 Если элемент не добавлен, то прерываем добавление в текущую строку.
                 */
                break;
            }

            cellObjectIndex++;
        }
    }

    /**
     @author Golovko Mikhail
     
     Один элемент из добавленных - это lastCellObject. Нам нужно показать,
     сколько элементов влезает из cellObjects, поэтому вычитаем единицу.
     */
    return self.rowCalculator.countAddItems - 1;
}

- (NSInteger)countRowsForObjects:(NSArray *)cellObjects {

    [self.rowCalculator cleanRows];

    for (id <NICollectionViewNibCellObject> cellObject in cellObjects) {

        CGSize size = [self sizeForCellObject:cellObject];

        [self.rowCalculator addItemAtWidth:size.width];
    }

    return self.rowCalculator.countRows;
}


#pragma mark - Дополнительные методы

- (UICollectionViewCell *)cellWithIdentifier:(id)identifier {
    return self.prototypeCells[identifier];
}

- (void)addCellToCache:(UICollectionViewCell *)cell withIdentifier:(id)identifier {
    self.prototypeCells[identifier] = cell;
}

- (UICollectionViewCell *)cellWithNib:(UINib *)nib
                               object:(id)object {
    UICollectionViewCell* cell = nil;

    NSString* identifier = NSStringFromClass([object class]);

    cell = [self cellWithIdentifier:identifier];

    if (!cell) {
        cell = [[nib instantiateWithOwner:nil
                                  options:nil] firstObject];
        if (cell) {
            [self addCellToCache:cell withIdentifier:identifier];
        }
    }

    return cell;
}

- (CGSize)fullSizeForCellObject:(id <NICollectionViewNibCellObject>)cellObject {

    UICollectionViewCell* cell = nil;

    UINib *nib = [cellObject collectionViewCellNib];
    if (nib) {
        cell = [self cellWithNib:nib object:cellObject];
    }

    if ([cell respondsToSelector:@selector(shouldUpdateCellWithObject:)]) {
        [(id<NICollectionViewCell>)cell shouldUpdateCellWithObject:cellObject];
    }

    return [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

- (CGSize)compressingCellSize:(CGSize)cellSize {
    CGFloat maxWidth = self.config.contentWidth;
    cellSize.width = MIN(cellSize.width, maxWidth);
    return cellSize;
}

@end