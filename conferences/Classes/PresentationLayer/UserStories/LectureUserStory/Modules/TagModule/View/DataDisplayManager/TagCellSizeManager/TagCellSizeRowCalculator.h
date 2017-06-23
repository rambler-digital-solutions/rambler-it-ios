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

/**
 @author Golovko Mikhail
 
 Вспомогательный класс для расчёта количества влезаемых элементов в одну строку.
 */
@interface TagCellSizeRowCalculator : NSObject

/**
 @author Golovko Mikhail
 
 Объект конфигурации размеров.
 */
@property (nonatomic, strong, readonly) TagCellSizeConfig *config;
/**
 @author Golovko Mikhail
 
 Количество заполненных строк.
 */
@property (nonatomic, assign, readonly) NSInteger countRows;
/**
 @author Golovko Mikhail
 
 Количество добавленных элементов.
 */
@property (nonatomic, assign, readonly) NSInteger countAddItems;

- (instancetype)initWithConfig:(TagCellSizeConfig *)config;

/**
 @author Golovko Mikhail
 
 Метод добавляет новй элемент. Если элемент не влазиет на текущую строку,
 автоматически создастся новая.
 
 @param itemWidth Ширина добавляемого элемента.
 */
- (void)addItemAtWidth:(CGFloat)itemWidth;

/**
 @author Golovko Mikhail
 
 Метод добавляет новй элемент в текущую строку. Если элемент невозможно добавить,
 вернёт NO.
 
 @param itemWidth Ширина добавляемого элемента.
 
 @return Был ли добавлен элемент YES/NO.
 */
- (BOOL)addItemInSameRowAtWidth:(CGFloat)itemWidth;

/**
 @author Golovko Mikhail
 
 Метод очищает все заполненные строки. Обнуляет всё.
 Просле вызово этого метода необходимо добавить новую строку через addNewRow,
 иначе при добавлении через addItemInSameRowAtWidth добавить будет невозможно,
 так как количество строк countRows нулевое. А если нету строк, то и добавлять некуда.
 */
- (void)cleanRows;

/**
 @author Golovko Mikhail
 
 Меметод добавляет новую строку.
 */
- (void)addNewRow;

@end