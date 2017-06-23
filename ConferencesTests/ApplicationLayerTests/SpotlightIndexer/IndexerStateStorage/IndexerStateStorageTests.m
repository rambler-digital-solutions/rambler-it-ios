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

#import <XCTest/XCTest.h>
#import <MagicalRecord/MagicalRecord.h>
#import <OCMock/OCMock.h>

#import "XCTestCase+RCFHelpers.h"

#import "IndexerStateStorage.h"
#import "IndexTransaction.h"
#import "IndexTransactionBatch.h"
#import "ChangeProviderChangeType.h"
#import "IndexState.h"
#import "ContextProvider.h"

@interface IndexerStateStorageTests : XCTestCase

@property (nonatomic, strong) IndexerStateStorage *stateStorage;
@property (nonatomic, strong) id mockContextProvider;

@end

@implementation IndexerStateStorageTests

- (void)setUp {
    [super setUp];
    [self tearDownCoreDataStack];
    [self setupCoreDataStackForTests];
    
    self.mockContextProvider = OCMProtocolMock(@protocol(ContextProvider));
    OCMStub([self.mockContextProvider obtainPrimaryContext]).andReturn([NSManagedObjectContext MR_rootSavingContext]);
    
    self.stateStorage = [IndexerStateStorage stateStorageWithContextProvider:self.mockContextProvider];
}

- (void)tearDown {
    self.stateStorage = nil;
    
    self.mockContextProvider = nil;
    
    [self tearDownCoreDataStack];
    
    [super tearDown];
}

- (void)testThatStateStorageInsertsSingleTransaction {
    // given
    NSString *const kTestIdentifier = @"1234";
    NSString *const kTestObjectType = @"event";
    IndexTransaction *transaction = [IndexTransaction transactionWithIdentifier:kTestIdentifier
                                                                     objectType:kTestObjectType
                                                                     changeType:ChangeProviderChangeInsert];
    
    // when
    [self.stateStorage insertTransaction:transaction];
    
    // then
    IndexState *state = [IndexState MR_findFirst];
    NSString *resultObjectType = state.objectType;
    NSString *resultIdentifier = [state.insertIdentifiers firstObject];
    XCTAssertEqualObjects(resultObjectType, kTestObjectType);
    XCTAssertEqualObjects(resultIdentifier, kTestIdentifier);
    XCTAssertNotNil(state.lastChangeDate);
}

- (void)testThatStateStorageInsertsMultipleTransactions {
    // given
    NSUInteger const kTestIdentifiersCount = 5;
    NSUInteger const kTestTransactionArraysCount = 10;
    NSArray *testArray = [self generateTransactionArraysWithCount:kTestTransactionArraysCount
                                                       innerCount:kTestIdentifiersCount];
    
    // when
    [self.stateStorage insertTransactionsArray:testArray
                                    changeType:ChangeProviderChangeInsert];
    
    // then
    NSArray *states = [IndexState MR_findAll];
    XCTAssertEqual(states.count, kTestTransactionArraysCount);
    
    for (IndexState *state in states) {
        XCTAssertEqual(state.insertIdentifiers.count, kTestIdentifiersCount);
        XCTAssertNotNil(state.lastChangeDate);
    }
}

- (void)testThatIndexerStorageReturnsTransactionBatch {
    // given
    NSUInteger const kTestTransactionsCount = 10;
    NSString *const kTestObjectType = @"event";
    NSArray *testArray = [self generateTransactionsWithCount:kTestTransactionsCount
                                                  objectType:kTestObjectType];
    for (IndexTransaction *transaction in testArray) {
        [self.stateStorage insertTransaction:transaction];
    }
    
    // when
    IndexTransactionBatch *result = [self.stateStorage obtainTransactionBatch];
    
    // then
    XCTAssertEqual(result.insertIdentifiers.count, kTestTransactionsCount);
    XCTAssertEqualObjects(result.objectType, kTestObjectType);
}

- (void)testThatStateStorageRemovesProcessedBatch {
    // given
    NSUInteger const kTestTransactionsCount = 10;
    NSString *const kTestObjectType = @"event";
    NSArray *testArray = [self generateTransactionsWithCount:kTestTransactionsCount
                                                  objectType:kTestObjectType];
    for (IndexTransaction *transaction in testArray) {
        [self.stateStorage insertTransaction:transaction];
    }
    IndexTransactionBatch *batch = [self.stateStorage obtainTransactionBatch];
    
    // when
    [self.stateStorage removeProcessedBatch:batch];
    
    // then
    IndexState *state = [IndexState MR_findFirst];
    IndexTransactionBatch *result = [self.stateStorage obtainTransactionBatch];
    XCTAssertNil(result);
    XCTAssertEqual([state.numberOfIdentifiers integerValue], 0);
}

- (void)testThatStateStorageDetectsWhenWeShouldPerformInitialIndexing {
    // given

    
    // when
    BOOL result = [self.stateStorage shouldPerformInitialIndexing];
    
    // then
    XCTAssertTrue(result);
}

- (void)testThatStateStorageDetectsWhenWeShouldNotPerformInitialIndexing {
    // given
    NSUInteger const kTestTransactionsCount = 10;
    NSString *const kTestObjectType = @"event";
    NSArray *testArray = [self generateTransactionsWithCount:kTestTransactionsCount
                                                  objectType:kTestObjectType];
    for (IndexTransaction *transaction in testArray) {
        [self.stateStorage insertTransaction:transaction];
    }
    
    // when
    BOOL result = [self.stateStorage shouldPerformInitialIndexing];
    
    // then
    XCTAssertFalse(result);
}

#pragma mark - Private methods

- (NSArray <NSArray *>*)generateTransactionArraysWithCount:(NSUInteger)count
                                                innerCount:(NSUInteger)innerCount {
    NSMutableArray *result = [NSMutableArray new];
    
    for (NSUInteger i = 0; i < count; i++) {
        NSArray *array = [self generateTransactionsWithCount:innerCount
                                                  objectType:[[NSUUID UUID] UUIDString]];
        [result addObject:array];
    }
    
    return [result copy];
}

- (NSArray *)generateTransactionsWithCount:(NSUInteger)count
                                objectType:(NSString *)objectType {
    NSMutableArray *mutableTransactions = [NSMutableArray new];
    for (NSUInteger i = 0; i < count; i++) {
        IndexTransaction *transaction = [IndexTransaction transactionWithIdentifier:[[NSUUID UUID] UUIDString]
                                                                         objectType:objectType
                                                                         changeType:ChangeProviderChangeInsert];
        [mutableTransactions addObject:transaction];
    }
    return [mutableTransactions copy];
}

- (IndexTransactionBatch *)generateTransactionBatchForTestPurposesWithObjectType:(NSString *)objectType
                                                               insertIdentifiers:(NSOrderedSet *)insertIdentifiers {
    IndexTransactionBatch *batch = [IndexTransactionBatch batchWithObjectType:objectType
                                                            insertIdentifiers:insertIdentifiers
                                                            updateIdentifiers:nil
                                                            deleteIdentifiers:nil
                                                              moveIdentifiers:nil];
    
    return batch;
}

@end
