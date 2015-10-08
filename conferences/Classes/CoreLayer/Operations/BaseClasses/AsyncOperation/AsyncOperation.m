//
//  AsyncOperation.m
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "AsyncOperation.h"

static NSString *const kExecutingFlagSelector = @"isExecuting";
static NSString *const kFinishedFlagSelector = @"isFinished";

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

#pragma mark - Getters

- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

#pragma mark - Private methods

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
        [self willChangeValueForKey:kFinishedFlagSelector];
        finished = YES;
        [self didChangeValueForKey:kFinishedFlagSelector];
        return;
    }
    
    /**
     @author Egor Tolstoy
     
     If it wasn't cancelled, we're beginning the task
     */
    [self willChangeValueForKey:kExecutingFlagSelector];
    
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:kExecutingFlagSelector];
}

- (void)main {
    [NSException raise:NSInternalInconsistencyException
                format:@"You should override the method %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void)complete {
    /**
     @author Egor Tolstoy
     
     We should always manually setup finished and executing flags after the operation is complete
     */
    [self willChangeValueForKey:kFinishedFlagSelector];
    [self willChangeValueForKey:kExecutingFlagSelector];
    
    executing = NO;
    finished = YES;
    
    [self didChangeValueForKey:kExecutingFlagSelector];
    [self didChangeValueForKey:kFinishedFlagSelector];
}

@end
