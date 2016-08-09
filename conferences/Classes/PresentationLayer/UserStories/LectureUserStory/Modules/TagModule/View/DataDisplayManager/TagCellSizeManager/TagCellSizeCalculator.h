//
// TagCellSizeCalculator.h
// LiveJournal
// 
// Created by Golovko Mikhail on 17/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

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

@end