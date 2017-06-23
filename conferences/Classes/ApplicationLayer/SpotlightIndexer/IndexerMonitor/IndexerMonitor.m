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

#import "IndexerMonitor.h"

#import "ChangeProvider.h"
#import "ObjectIndexer.h"
#import "IndexTransaction.h"
#import "IndexTransactionBatch.h"
#import "IndexerStateStorage.h"
#import "IndexerMonitorOperationQueueFactory.h"

#import "EXTScope.h"

@interface IndexerMonitor ()

@property (nonatomic, strong) NSArray *indexers;
@property (nonatomic, strong) NSArray *changeProviders;
@property (nonatomic, strong) IndexerStateStorage *stateStorage;
@property (nonatomic, strong) IndexerMonitorOperationQueueFactory *queueFactory;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation IndexerMonitor

#pragma mark - Initialization

- (instancetype)initWithIndexers:(NSArray<id<ObjectIndexer>> *)indexers
                 changeProviders:(NSArray<id<ChangeProvider>> *)changeProviders
                    stateStorage:(IndexerStateStorage *)stateStorage
                    queueFactory:(IndexerMonitorOperationQueueFactory *)queueFactory {
    self = [super init];
    if (self) {
        _indexers = indexers;
        _changeProviders = changeProviders;
        _stateStorage = stateStorage;
        _queueFactory = queueFactory;
    }
    return self;
}

+ (instancetype)monitorWithIndexers:(NSArray <id<ObjectIndexer>> *)indexers
                    changeProviders:(NSArray <id<ChangeProvider>> *)changeProviders
                       stateStorage:(IndexerStateStorage *)stateStorage
                       queueFactory:(IndexerMonitorOperationQueueFactory *)queueFactory {
    return [[self alloc] initWithIndexers:indexers
                          changeProviders:changeProviders
                             stateStorage:stateStorage
                             queueFactory:queueFactory];
}

#pragma mark - Public methods

- (void)startMonitoring {
    if (!self.operationQueue) {
        self.operationQueue = [self.queueFactory createIndexerOperationQueue];
    }
    
    for (id<ChangeProvider> changeProvider in self.changeProviders) {
        changeProvider.delegate = self;
        [changeProvider startMonitoring];
    }

    [self performInitialIndexingIfNeeded];
}

- (void)stopMonitoring {
    for (id<ChangeProvider> changeProvider in self.changeProviders) {
        [changeProvider stopMonitoring];
    }
    [self.operationQueue cancelAllOperations];
}

#pragma mark - <ChangeProviderDelegate>

- (void)changeProvider:(id<ChangeProvider>)changeProvider
  didGetChangeWithType:(ChangeProviderChangeType)changeType
         forObjectType:(NSString *)objectType
      objectIdentifier:(NSString *)objectIdentifier {
    IndexTransaction *transaction = [IndexTransaction transactionWithIdentifier:objectIdentifier
                                                                     objectType:objectType
                                                                     changeType:changeType];
    [self.stateStorage insertTransaction:transaction];
}

- (void)didFinishChangingObjectsInChangeProvider:(id<ChangeProvider>)changeProvider {
    [self processIndexing];
}

#pragma mark - Private methods

- (void)performInitialIndexingIfNeeded {
    BOOL needed = [self.stateStorage shouldPerformInitialIndexing];
    if (needed) {
        NSMutableArray *allTransactions = [NSMutableArray new];
        for (id<ChangeProvider> changeProvider in self.changeProviders) {
            __block NSMutableArray *providerTransactions = [NSMutableArray new];
            [changeProvider processObjectsForInitialIndexingWithBlock:^(NSString *objectType, NSString *objectIdentifier) {
                IndexTransaction *transaction = [IndexTransaction transactionWithIdentifier:objectIdentifier
                                                                                 objectType:objectType
                                                                                 changeType:ChangeProviderChangeInsert];
                [providerTransactions addObject:transaction];
            }];
            [allTransactions addObject:providerTransactions];
        }
        [self.stateStorage insertTransactionsArray:[allTransactions copy]
                                        changeType:ChangeProviderChangeInsert];
        [self processIndexing];
    }
}

- (void)processIndexing {
    IndexTransactionBatch *batch = [self.stateStorage obtainTransactionBatch];
    if (!batch || [batch isEmpty]) {
        return;
    }
    id<ObjectIndexer> indexer = [self obtainIndexerForObjectType:batch.objectType];
    
    @weakify(self);
    NSOperation *indexOperation = [indexer operationForIndexBatch:batch
                                              withCompletionBlock:^(NSError *error) {
                                                  @strongify(self);
                                                  [self.stateStorage removeProcessedBatch:batch];
                                                  [self processIndexing];
                                              }];
    [self.operationQueue addOperation:indexOperation];
}

- (id<ObjectIndexer>)obtainIndexerForObjectType:(NSString *)objectType {
    id<ObjectIndexer> result = nil;
    for (id<ObjectIndexer> indexer in self.indexers) {
        if ([indexer canIndexObjectWithType:objectType]) {
            result = indexer;
            break;
        }
    }
    return result;
}

@end
