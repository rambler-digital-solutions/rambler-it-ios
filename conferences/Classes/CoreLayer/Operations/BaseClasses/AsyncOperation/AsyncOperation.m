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
    /**
     @author Egor Tolstoy
     
     Always check, if the operation was cancelled before the start
     */
    if ([self isCancelled])
    {
        /**
         @author Egor Tolstoy
         
         If it was cancelled, we are switching it to finished state
         */
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    /**
     @author Egor Tolstoy
     
     If it wasn't cancelled, we're beginning the task
     */
    [self willChangeValueForKey:@"isExecuting"];
    
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)main {
    [NSException raise:NSInternalInconsistencyException
                format:@"Требуется переопределить метод %@ в конкретном наследнике", NSStringFromSelector(_cmd)];
}

- (void)complete {
    /**
     @author Egor Tolstoy
     
     We should always manually setup finished and executing flags after the operation is complete
     */
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    executing = NO;
    finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end
