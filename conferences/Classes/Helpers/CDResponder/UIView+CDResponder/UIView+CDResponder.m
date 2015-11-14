//
//  UIView+CDResponder.m
//  testNavBatr
//
//  Created by Smal Vadim on 23.04.15.
//  Copyright (c) 2015 Smal Vadim. All rights reserved.
//

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
