//
// TagCellSizeRowCalculator.h
// LiveJournal
// 
// Created by Golovko Mikhail on 30/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

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