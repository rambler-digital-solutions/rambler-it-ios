//
//  TagViewInput.h
//  liveJournal
//
//  Created by Golovko Mikhail on 15/12/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TagViewInput <NSObject>

/**
 @author Golovko Mikhail

 Метод настраивает начальный стейт view
 */
- (void)setupInitialState;

/**
 @author Golovko Mikhail
 
 Метод инициирует отображение тегов
 
 @param tags Список тегов
 */
- (void)showTags:(NSArray *)tags;

/**
 @author Golovko Mikhail
 
 Метод конфигурирует вертикальное отображение
 */
- (void)setupVerticalContentAlign;

/**
 @author Golovko Mikhail
 
 Метод конфигурирует горизонтальное отображение
 */
- (void)setupHorizontalContentAlign;

/**
 @author Golovko Mikhail
 
 Метод скрывает кнопку добавить тег
 */
- (void)hideAddButton;

/**
 @author Golovko Mikhail
 
 Метод отображает кнопку добавить тег
 */
- (void)showAddButton;

/**
 @author Golovko Mikhail
 
 Метод включает кнопку удаления у тегов
 */
- (void)enableRemoveTag;

/**
 @author Golovko Mikhail
 
 Метод отключает кнопку удаления у тегов
 */
- (void)disableRemoveTag;

/**
 @author Golovko Mikhail
 
 Метод удаляет тег с вьюшки
 
 @param index Индекс удаляемого тега
 */
- (void)removeTagAtIndex:(NSInteger)index;

/**
 @author Golovko Mikhail
 
 Метод добавляет тег на вьюшку
 
 @param tagName Имя тега
 */
- (void)appendTagWithName:(NSString *)tagName;

/**
 @author Golovko Mikhail
 
 Метод настраивает количество отображаемых строк
 
 @param lines Количество отображаемых строк
 */
- (void)setupShowNumberOfLines:(NSInteger)lines;

@end