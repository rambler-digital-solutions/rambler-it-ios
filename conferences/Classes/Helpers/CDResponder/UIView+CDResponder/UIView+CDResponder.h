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

#import <UIKit/UIKit.h>

typedef BOOL (^CDExpectedBlock)(void * value);

/**
 Категория UIView для поиска
 UIResponser'ов
 */
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
