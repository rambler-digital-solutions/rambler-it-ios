//
// TagCellSizeConfig.h
// LiveJournal
// 
// Created by Golovko Mikhail on 30/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 @author Golovko Mikhail
 
 Модель настроек для расчёта размеров ячеек тегов
 */
@interface TagCellSizeConfig : NSObject

/**
 @author Golovko Mikhail
 
 Ширина компонента отображения тегов
 */
@property (nonatomic, assign, readonly) CGFloat contentWidth;

/**
 @author Golovko Mikhail
 
 Отступ между элементами
 */
@property (nonatomic, assign, readonly) CGFloat itemSpacing;

/**
 @author Golovko Mikhail
 
 Метод возвращает дефолтную конфигурацию
 
 @return TagCellSizeConfig
 */
+ (instancetype)defaultConfig;

- (instancetype)initWithContentWidth:(CGFloat)contentWidth
                         itemSpacing:(CGFloat)itemSpacing;


@end