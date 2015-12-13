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
        _queue.name = [NSString stringWithFormat:@"ru.rambler.conferences.%@-%@.queue", NSStringFromClass([self class]), [[NSUUID UUID] UUIDString]];
        _queue.maxConcurrentOperationCount = _maxConcurrentOperationsCount > 0 ?: DefaultMaxConcurrentOperationsCount;

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

#pragma mark - Protocol ChainableOperationDelegate

- (void)didCompleteChainableOperationWithError:(NSError *)error {
    id data = [self.queueOutput obtainOperationQueueOutputData];

    /**
     @author Egor Tolstoy
     
     We should finish the operation in two cases:
     - If an error occures,
     - When the queue is finished (queueOutput is not nil)
     */
    if (error || data) {
        [self completeOperationWithData:data error:error];
    }
}

#pragma mark - Private methods

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
