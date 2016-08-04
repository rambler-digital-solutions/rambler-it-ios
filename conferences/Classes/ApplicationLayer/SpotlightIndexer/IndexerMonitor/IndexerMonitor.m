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
#import "ChangeProviderDelegate.h"
#import "ObjectIndexer.h"
#import "IndexTransaction.h"
#import "IndexTransactionBatch.h"
#import "IndexerStateStorage.h"

#import "EXTScope.h"

@interface IndexerMonitor () <ChangeProviderDelegate>

@property (nonatomic, strong) NSArray *indexers;
@property (nonatomic, strong) NSArray *changeProviders;

@end

@implementation IndexerMonitor

#pragma mark - Initialization

- (instancetype)initWithIndexers:(NSArray<id<ObjectIndexer>> *)indexers
                 changeProviders:(NSArray<id<ChangeProvider>> *)changeProviders {
    self = [super init];
    if (self) {
        _indexers = indexers;
        _changeProviders = changeProviders;
        
        for (id<ChangeProvider> changeProvider in _changeProviders) {
            changeProvider.delegate = self;
        }
    }
    return self;
}

+ (instancetype)monitorWithIndexers:(NSArray<id<ObjectIndexer>> *)indexers
                    changeProviders:(NSArray<id<ChangeProvider>> *)changeProviders {
    return [[self alloc] initWithIndexers:indexers
                          changeProviders:changeProviders];
}

#pragma mark - Public methods

- (void)startMonitoring {
    for (id<ChangeProvider> changeProvider in self.changeProviders) {
        [changeProvider startMonitoringForChanges];
    }
    [self performInitialIndexingIfNeeded];
}

- (void)stopMonitoring {
    
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
    [indexOperation start];
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
