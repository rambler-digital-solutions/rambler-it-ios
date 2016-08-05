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

#import "ObjectIndexerBase.h"

#import "ObjectTransformer.h"
#import "IndexTransactionBatch.h"

#import "EXTScope.h"

#import <CoreSpotlight/CoreSpotlight.h>

@interface ObjectIndexerBase ()

@property (nonatomic, strong) id<ObjectTransformer> objectTransformer;
@property (nonatomic, strong) CSSearchableIndex *searchableIndex;

@end

@implementation ObjectIndexerBase

#pragma mark - Initialization

- (instancetype)initWithObjectTransformer:(id<ObjectTransformer>)objectTransformer
                          searchableIndex:(CSSearchableIndex *)searchableIndex {
    self = [super init];
    if (self) {
        _objectTransformer = objectTransformer;
        _searchableIndex = searchableIndex;
    }
    return self;
}

#pragma mark - <ObjectIndexer>

- (NSOperation *)operationForIndexBatch:(IndexTransactionBatch *)batch
                    withCompletionBlock:(IndexerErrorBlock)block {
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSMutableArray *items = [NSMutableArray array];
        
        NSMutableOrderedSet *indexSet = [NSMutableOrderedSet new];
        [indexSet addObjectsFromArray:[batch.insertIdentifiers array]];
        [indexSet addObjectsFromArray:[batch.updateIdentifiers array]];
        
        NSArray *deleteIdentifiers = [batch.deleteIdentifiers array];
        [indexSet removeObjectsInArray:deleteIdentifiers];
        
        for (NSString *identifier in indexSet) {
            id object = [self.objectTransformer objectForIdentifier:identifier];
            if (object) {
                CSSearchableItem *item = [self searchableItemForObject:object];
                if (item) {
                    [items addObject:item];
                }
            }
        }
        
        @weakify(self);
        [self.searchableIndex indexSearchableItems:items
                                 completionHandler:^(NSError * _Nullable error) {
                                     @strongify(self);
                                     if (error) {
                                         block(error);
                                         return;
                                     }
                                     [self.searchableIndex deleteSearchableItemsWithIdentifiers:deleteIdentifiers
                                                                              completionHandler:^(NSError * _Nullable error) {
                                                                                  block(error);
                                                                              }];
                                 }];
    }];
    return operation;
}

- (NSString *)identifierForObject:(id)object {
    return [self.objectTransformer identifierForObject:object];
}

#pragma mark - Abstract methods

- (BOOL)canIndexObjectWithType:(NSString *)objectType {
    [NSException raise:NSInternalInconsistencyException
                format:@"You should override this method in a custom subclass"];
    return NO;
}

- (CSSearchableItem *)searchableItemForObject:(id)object {
    [NSException raise:NSInternalInconsistencyException
                format:@"You should override this method in a custom subclass"];
    return nil;
}

@end
