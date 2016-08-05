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
#import <OCMock/OCMock.h>
#import <CoreSpotlight/CoreSpotlight.h>

#import "ObjectIndexerBase.h"
#import "IndexTransactionBatch.h"
#import "SearchableIndexMock.h"

#import "ObjectTransformer.h"

@interface ObjectIndexerBaseTests : XCTestCase

@property (nonatomic, strong) ObjectIndexerBase *indexer;
@property (nonatomic, strong) id mockIndexer;
@property (nonatomic, strong) id mockTransformer;
@property (nonatomic, strong) SearchableIndexMock *mockIndex;

@end

@implementation ObjectIndexerBaseTests

- (void)setUp {
    [super setUp];
    
    self.mockTransformer = OCMProtocolMock(@protocol(ObjectTransformer));
    self.mockIndex = [SearchableIndexMock new];
    
    self.indexer = [[ObjectIndexerBase alloc] initWithObjectTransformer:self.mockTransformer
                                                        searchableIndex:self.mockIndex];
    self.mockIndexer = OCMPartialMock(self.indexer);
}

- (void)tearDown {
    [(id)self.mockIndexer stopMocking];
    self.mockIndexer = nil;
    
    self.indexer = nil;
    
    self.mockTransformer = nil;
    
    self.mockIndex = nil;
    
    [super tearDown];
}

- (void)testThatIndexerReturnsIdentifierForObject {
    // given
    NSString *const kTestIdentifier = @"1234";
    
    id mockObject = [NSObject new];
    OCMStub([self.mockTransformer identifierForObject:mockObject]).andReturn(kTestIdentifier);
    
    // when
    NSString *result = [self.indexer identifierForObject:mockObject];
    
    // then
    XCTAssertEqualObjects(result, kTestIdentifier);
}

- (void)testThatIndexerOperationIndexesSearchableItem {
    // given
    CSSearchableItem *testItem = [self generateSearchableItemForTestPurposes];
    
    NSString *const kTestIdentifier = @"1234";
    IndexTransactionBatch *batch = [self generateBarchForTestPurposesWithIdentifier:kTestIdentifier];
    
    id mockObject = [NSObject new];
    OCMStub([self.mockTransformer objectForIdentifier:kTestIdentifier]).andReturn(mockObject);
    OCMStub([self.mockIndexer searchableItemForObject:mockObject]).andReturn(testItem);
    
    // when
    NSOperation *operation = [self.mockIndexer operationForIndexBatch:batch
                                                  withCompletionBlock:^(NSError *error) {}];
    [operation start];
    
    // then
    XCTAssertTrue([self.mockIndex.indexedItems containsObject:testItem]);
}

- (void)testThatIndexerOperationDeletesSearchableItem {
    // given
    CSSearchableItem *testItem = [self generateSearchableItemForTestPurposes];
    
    NSString *const kTestIdentifier = @"1234";
    IndexTransactionBatch *batch = [self generateDeletionBarchForTestPurposesWithIdentifier:kTestIdentifier];
    
    id mockObject = [NSObject new];
    OCMStub([self.mockTransformer objectForIdentifier:kTestIdentifier]).andReturn(mockObject);
    OCMStub([self.mockIndexer searchableItemForObject:mockObject]).andReturn(testItem);
    
    // when
    NSOperation *operation = [self.mockIndexer operationForIndexBatch:batch
                                                  withCompletionBlock:^(NSError *error) {}];
    [operation start];
    
    // then
    XCTAssertTrue([self.mockIndex.deletedIdentifiers containsObject:kTestIdentifier]);
}

#pragma mark - Helper methods

- (IndexTransactionBatch *)generateBarchForTestPurposesWithIdentifier:(NSString *)identifier {
    IndexTransactionBatch *batch = [IndexTransactionBatch batchWithObjectType:[[NSUUID UUID] UUIDString]
                                                            insertIdentifiers:[NSOrderedSet orderedSetWithArray:@[identifier]]
                                                            updateIdentifiers:nil
                                                            deleteIdentifiers:nil
                                                              moveIdentifiers:nil];
    return batch;
}

- (IndexTransactionBatch *)generateDeletionBarchForTestPurposesWithIdentifier:(NSString *)identifier {
    IndexTransactionBatch *batch = [IndexTransactionBatch batchWithObjectType:[[NSUUID UUID] UUIDString]
                                                            insertIdentifiers:nil
                                                            updateIdentifiers:nil
                                                            deleteIdentifiers:[NSOrderedSet orderedSetWithArray:@[identifier]]
                                                              moveIdentifiers:nil];
    return batch;
}

- (CSSearchableItem *)generateSearchableItemForTestPurposes {
    CSSearchableItemAttributeSet *set = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:[[NSUUID UUID] UUIDString]];
    CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:[[NSUUID UUID] UUIDString]
                                                               domainIdentifier:[[NSUUID UUID] UUIDString]
                                                                   attributeSet:set];
    return item;
}

@end
