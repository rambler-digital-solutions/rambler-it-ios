//
//  AsyncOperation.m
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "AsyncOperation.h"

@implementation AsyncOperation {
    BOOL        executing;
    BOOL        finished;
};

- (instancetype)init {
    self = [super init];
    if (self) {
        executing = NO;
        finished = NO;
    }
    return self;
}

#pragma mark - Геттеры

- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

#pragma mark - Приватные методы

- (void)start {
    // Перед стартом всегда требуется проверить, не отменили ли операцию
    if ([self isCancelled])
    {
        // Если операция была отменена, нужно перевести ее в состояние finished
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    // Если операция не была отменена, начинаем задачу
    [self willChangeValueForKey:@"isExecuting"];
    
    // Создаем новый тред и запускаем в нем операцию.
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)main {
    [NSException raise:NSInternalInconsistencyException
                format:@"Требуется переопределить метод %@ в конкретном наследнике", NSStringFromSelector(_cmd)];
}

- (void)complete {
    // При завершении операции всегда нужно выставить соответствующие флаги
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    executing = NO;
    finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end
