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
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TagCellSizeConfig;
@protocol NICollectionViewNibCellObject;
@class TagCellSizeRowCalculator;

/**
 @author Golovko Mikhail
 
 Калькулятор размера ячеек для модуля тегов
 */
@interface TagCellSizeCalculator : NSObject

/**
 @author Golovko Mikhail
 
 Флаг сжатия ячейки по ширине
 */
@property (nonatomic, assign) BOOL compressWidth;

/**
 @author Golovko Mikhail
 
 Дополнительный калькулятор для расчёта строк.
 */
@property (nonatomic, strong, readonly) TagCellSizeRowCalculator *rowCalculator;

/**
 @author Golovko Mikhail
 
 Объект конфигурации размеров.
 */
@property (nonatomic, strong, readonly) TagCellSizeConfig *config;

- (instancetype)initWithRowCalculator:(TagCellSizeRowCalculator *)rowCalculator
                               config:(TagCellSizeConfig *)config;


/**
 @author Golovko Mikhail
 
 Метод расчитывает размер ячейки
 
 @param collectionView UICollectionView для отображения
 @param cellObject     Объект модели ячейки
 
 @return Размер ячейки
 */
- (CGSize)sizeForCellObject:(id <NICollectionViewNibCellObject>)cellObject;

/**
 @author Golovko Mikhail
 
 Метод рассчитывает количество ячеек, которые поместятся в указанное число строк
 
 @param rows           Число строк, для которых нужно узнать количество влезаемых элементов
 @param cellObjects    Объекты ячеек для отображения
 @param lastCellObject Объект ячейки, который должен обязательно вместиться последним элементом
 
 @return Количество элементов из cellObjects, которые влезают в rows строк
 */
- (NSInteger)countItemsInRows:(NSInteger)rows
               forCellObjects:(NSArray *)cellObjects
               lastCellObject:(id <NICollectionViewNibCellObject>)lastCellObject;

/**
 @author Golovko Mikhail
 
 Метод рассчитвает количество строк, которые нужны для отображения элементов
 
 @param cellObjects Объекты ячеек, для которых нужно рассчитать количество строк
 
 @return Количество строк, которые нужны для отображения cellObjects
 */
- (NSInteger)countRowsForObjects:(NSArray *)cellObjects;

- (CGFloat)calculateHeightRowsForCellObjects:(NSArray *)cellObjects;

@end