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
#import "UIView+CDResponder.h"

@implementation UIView (CDResponder)

#pragma mark - Публичные методы

- (NSArray *)respondersForSelector:(SEL)selector {
    
    NSMutableArray *responders = [NSMutableArray new];
    
    [self insertResponderForSelector:selector inView:self toArray:&responders];
    
    return responders;
    
}

- (NSArray *)respondersForSelector:(SEL)selector responderClasses:(NSArray *)classes {
    
    NSArray *responders = [self respondersForSelector:selector];
    
    NSMutableArray *conformResponders = [NSMutableArray new];
    
    for (UIResponder *responder in responders) {
        Class responderClass = [responder class];
        if ([classes containsObject:responderClass]) {
            [conformResponders addObject:responder];
        }
    }
    
    return conformResponders;

}

- (NSArray *)respondersForSelector:(SEL)selector
                  responderClasses:(NSArray *)classes
                resultExpectedBlock:(CDExpectedBlock)compareBlock {
    
    NSArray *responders = [self respondersForSelector:selector responderClasses:classes];
    
    NSMutableArray *conformResponders = [NSMutableArray new];
    
    for (UIResponder *responder in responders) {
        
        void *result = [self returnValueOfSelector:selector
                                            target:responder];
        
        BOOL equal = compareBlock(result);
        
        if (equal) {
            [conformResponders addObject:responder];
        }
        
    }
    
    return conformResponders;

}

#pragma mark - Приватные методы

/**
 *  @author Vadim Smal
 *
 *  Рекурсивно ищем view отвечающие на селектор
 *
 *  @param selector Селектор
 *  @param view     UIView по subview которой проходимся
 *  @param array    Массив для добавления найденных
 */

- (void)insertResponderForSelector:(SEL)selector inView:(UIView *)view toArray:(NSMutableArray **)array {
    
    if ([view respondsToSelector:selector]) {
        [*array addObject:view];
    }
    
    for (UIView *subView in view.subviews) {
        [self insertResponderForSelector:selector inView:subView toArray:array];
    }
    
}

/**
 *  @author Vadim Smal
 *
 *  Выполняем селектор и возвращаем результат
 *
 *  @param selector Селектор
 *  @param target   Таргет
 *
 *  @return Результат выполнения селектора
 */

- (void *)returnValueOfSelector:(SEL)selector target:(id)target {
    
    NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:selector];
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:selector];
    [invocation setTarget:target];
    [invocation invoke];
    
    void *returned;
    [invocation getReturnValue:&returned];
    
    return returned;
}

@end
