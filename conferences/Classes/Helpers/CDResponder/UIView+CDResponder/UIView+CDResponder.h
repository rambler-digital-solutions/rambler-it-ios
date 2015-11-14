//
//  UIView+CDResponder.h
//  Категория UIView для поиска
//  UIResponser'ов
//
//  Created by Smal Vadim on 23.04.15.
//  Copyright (c) 2015 Smal Vadim. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL (^CDExpectedBlock)(void * value);

@interface UIView (CDResponder)

/**
 *  @author Vadim Smal
 *
 *  Поиск всех UIResponser'ов,
 *  которые отвечают на селектор
 *
 *  @param selector Селектор
 *
 *  @return Массив UIResponser'ов
 */
- (NSArray *)respondersForSelector:(SEL)selector;

/**
 *  @author Vadim Smal
 *
 *  Поиск всех UIResponser'ов,
 *  которые отвечают на селектор и класс
 *  содержится в responderClasses
 *
 *  @param selector Селектор
 *  @param classes  Массив содержащий классы
 *
 *  @return Массив UIResponser'ов
 */
- (NSArray *)respondersForSelector:(SEL)selector
                     responderClasses:(NSArray *)classes;

/**
 *  @author Vadim Smal
 *
 *  Поиск всех UIResponser'ов,
 *  которые отвечают на селектор, класс
 *  содержится в responderClasses и
 *  блок вернул на результат выполнения селектора YES
 *
 *  @param selector     Селектор
 *  @param classes      Массив содержащий классы
 *  @param compareBlock Блок возвращающий BOOL,
 *  если выполнения селектора ко которые мы ищем
 *
 *  @return Массив UIResponser'ов
 */
- (NSArray *)respondersForSelector:(SEL)selector
                  responderClasses:(NSArray *)classes
                resultExpectedBlock:(CDExpectedBlock)compareBlock;

@end
