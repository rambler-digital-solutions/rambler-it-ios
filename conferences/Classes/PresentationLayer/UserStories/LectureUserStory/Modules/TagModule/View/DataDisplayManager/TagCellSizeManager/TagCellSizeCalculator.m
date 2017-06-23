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

#import "TagCellSizeCalculator.h"
#import "TagCellSizeConfig.h"
#import "NICollectionViewCellFactory.h"
#import "TagCellSizeRowCalculator.h"
#import "TagCollectionViewCellObject.h"

@interface TagCellSizeCalculator ()

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

    size = [self compressingCellSize:size];

    return size;
}

- (NSInteger)countItemsInRows:(NSInteger)rows
               forCellObjects:(NSArray *)cellObjects {

    [self.rowCalculator cleanRows];

    /**
     @author Golovko Mikhail
     
     Индекс добавляемой ячейки.
     */
    NSUInteger cellObjectIndex = 0;

    for (int i = 0; i < rows; ++i) {

        [self.rowCalculator addNewRow];

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

    return self.rowCalculator.countAddItems;
}

- (NSInteger)countRowsForObjects:(NSArray *)cellObjects {

    [self.rowCalculator cleanRows];

    for (id <NICollectionViewNibCellObject> cellObject in cellObjects) {

        CGSize size = [self sizeForCellObject:cellObject];

        [self.rowCalculator addItemAtWidth:size.width];
    }

    return self.rowCalculator.countRows;
}

- (CGFloat)calculateHeightRowsForCellObjects:(NSArray *)cellObjects {
    NSInteger countRows = [self countRowsForObjects:cellObjects];
    CGFloat height = countRows * (self.config.itemHeight + self.config.itemSpacing);
    return height;
}

#pragma mark - Дополнительные методы

- (CGSize)fullSizeForCellObject:(TagCollectionViewCellObject *)cellObject {

    CGSize size = CGSizeMake(0, self.config.itemHeight);
    NSString *tagName = cellObject.tagName;
    CGFloat widthText = [tagName boundingRectWithSize:size
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{ NSFontAttributeName:self.config.font }
                                          context:nil].size.width;
    size.width = ceil(widthText) + ceil(self.config.itemSideInset) * 2;
    return size;
}

- (CGSize)compressingCellSize:(CGSize)cellSize {
    CGFloat maxWidth = self.config.contentWidth;
    cellSize.width = MIN(cellSize.width, maxWidth);
    return cellSize;
}

@end