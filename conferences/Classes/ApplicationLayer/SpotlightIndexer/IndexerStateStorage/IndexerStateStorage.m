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

#import "IndexerStateStorage.h"

#import "IndexTransaction.h"
#import "IndexTransactionBatch.h"
#import "IndexState.h"

#import <MagicalRecord/MagicalRecord.h>

static NSUInteger const kTransactionBatchSize = 1000;

@implementation IndexerStateStorage

#pragma mark - Public methods

- (void)insertTransaction:(IndexTransaction *)transaction {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    [rootSavingContext MR_saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        IndexState *state = [IndexState MR_findFirstOrCreateByAttribute:NSStringFromSelector(@selector(objectType))
                                                                    withValue:transaction.objectType
                                                                    inContext:localContext];
        [state insertIdentifier:transaction.identifier
                        forType:transaction.changeType];
        state.lastChangeDate = [NSDate date];
    }];
}

- (void)insertTransactionsArray:(NSArray<NSArray *> *)transactionsArray
                     changeType:(ChangeProviderChangeType)changeType {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    [rootSavingContext MR_saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        for (NSArray *transactions in transactionsArray) {
            if (transactions.count) {
                NSString *objectType = [[transactions firstObject] objectType];
                IndexState *state = [IndexState MR_findFirstOrCreateByAttribute:NSStringFromSelector(@selector(objectType))
                                                                      withValue:objectType
                                                                      inContext:localContext];
                NSArray *identifiers = [transactions valueForKey:@"identifier"];
                [state insertIdentifiers:identifiers
                                 forType:changeType];
                state.lastChangeDate = [NSDate date];
            }
        }
    }];
}

- (IndexTransactionBatch *)obtainTransactionBatch {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"numberOfIdentifiers > 0"];
    
    IndexState *state = [IndexState MR_findFirstWithPredicate:predicate
                                                     sortedBy:NSStringFromSelector(@selector(lastChangeDate))
                                                    ascending:YES
                                                    inContext:rootSavingContext];
    
    if (state.insertIdentifiers.count == 0 &&
        state.updateIdentifiers.count == 0 &&
        state.deleteIdentifiers.count == 0 &&
        state.moveIdentifiers.count == 0) {
        return nil;
    }
    
    NSArray *setArray = @[state.insertIdentifiers ?: [NSOrderedSet new],
                          state.updateIdentifiers ?: [NSOrderedSet new],
                          state.deleteIdentifiers ?: [NSOrderedSet new],
                          state.moveIdentifiers ?: [NSOrderedSet new]];
    
    NSMutableArray *sliceSetsArray = [NSMutableArray new];
    
    for (NSOrderedSet *set in setArray) {
        NSArray *array = [set array];
        NSUInteger length = MIN(array.count, kTransactionBatchSize);
        NSRange range = NSMakeRange(0, length);
        NSArray *sliceArray = [array subarrayWithRange:range];
        NSOrderedSet *sliceSet = [[NSOrderedSet alloc] initWithArray:sliceArray];
        [sliceSetsArray addObject:sliceSet];
    }
    
    return [IndexTransactionBatch batchWithObjectType:state.objectType
                                    insertIdentifiers:sliceSetsArray[0]
                                    updateIdentifiers:sliceSetsArray[1]
                                    deleteIdentifiers:sliceSetsArray[2]
                                      moveIdentifiers:sliceSetsArray[3]];
}

- (void)removeProcessedBatch:(IndexTransactionBatch *)batch {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    [rootSavingContext MR_saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        
        IndexState *state = [IndexState MR_findFirstOrCreateByAttribute:NSStringFromSelector(@selector(objectType))
                                                              withValue:batch.objectType
                                                              inContext:localContext];
        
        NSArray *changeTypes = @[@(NSFetchedResultsChangeInsert),
                                 @(NSFetchedResultsChangeUpdate),
                                 @(NSFetchedResultsChangeMove),
                                 @(NSFetchedResultsChangeDelete)];
        
        NSArray *batchChanges = @[batch.insertIdentifiers,
                                  batch.updateIdentifiers,
                                  batch.moveIdentifiers,
                                  batch.deleteIdentifiers];
        
        for (int i = 0; i < changeTypes.count; i++) {
            NSNumber *changeTypeNumber = changeTypes[i];
            NSFetchedResultsChangeType changeType = [changeTypeNumber unsignedIntegerValue];
            NSOrderedSet *identifiers = batchChanges[i];
            NSArray *identifierArray = [identifiers array];
            [state removeIdentifiers:identifierArray
                             forType:changeType];
        }
        
        state.lastChangeDate = [NSDate date];
        
    }];
}

- (BOOL)shouldPerformInitialIndexing {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    IndexState *state = [IndexState MR_findFirstInContext:rootSavingContext];
    return state == nil;
}

@end
