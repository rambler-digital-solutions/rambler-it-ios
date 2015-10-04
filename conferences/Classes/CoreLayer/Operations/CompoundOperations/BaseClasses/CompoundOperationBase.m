//
//  CompoundOperationBase.m
//  LiveJournal
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "CompoundOperationBase.h"

#import "CompoundOperationDebugDescriptionFormatter.h"

static NSUInteger const DefaultMaxConcurrentOperationsCount = 3;

@interface CompoundOperationBase ()

@property (strong, nonatomic) NSOperationQueue *queue;

@end

@implementation CompoundOperationBase

- (instancetype)init {
    self = [super init];
    if (self) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.name = [NSString stringWithFormat:@"LiveJournal.%@-%@.queue", NSStringFromClass([self class]), [[NSUUID UUID] UUIDString]];
        _queue.maxConcurrentOperationCount = _maxConcurrentOperationsCount > 0 ?: DefaultMaxConcurrentOperationsCount;
        
        // По умолчанию очередь должна быть остановлена, запускается одновременно с началом выполнения самой операции
        [_queue setSuspended:YES];
    }
    return self;
}

- (void)main {
    [self.queue setSuspended:NO];
}

- (void)cancel {
    [super cancel];
    
    [self.queue cancelAllOperations];
    [self completeOperationWithData:nil error:nil];
}

- (void)addOperation:(NSOperation *)operation {
    [self.queue addOperation:operation];
}

#pragma mark - Методы ChainableOperationDelegate

- (void)didCompleteChainableOperationWithError:(NSError *)error {
    id data = [self.queueOutput obtainOperationQueueOutputData];

    /**
     @author Egor Tolstoy
     
     Завершать операцию нужно в двух случаях:
     - Случилась ошибка
     - Очередь операций закончилась (т.е. есть data у queueOutput)
     */
    if (error || data) {
        [self completeOperationWithData:data error:error];
    }
}

#pragma mark - Приватные методы

- (void)completeOperationWithData:(id)data error:(NSError *)error {
    [self.queue cancelAllOperations];
    [self complete];
    
    if (self.resultBlock) {
        self.resultBlock(data, error);
    }
}

#pragma mark - Debug

- (NSString *)debugDescription {
    return [CompoundOperationDebugDescriptionFormatter debugDescriptionForCompoundOperation:self
                                                                          withInternalQueue:self.queue];
}

@end
