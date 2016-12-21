//
//  EventImageIndexerTests.m
//  Conferences
//
//  Created by k.zinovyev on 21.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreSpotlight/CoreSpotlight.h>
#import <OCMock/OCMock.h>
#import <MagicalRecord/MagicalRecord.h>
#import "EventImageIndexer.h"
#import "EventObjectIndexer.h"
#import "EventModelObject.h"
#import "SpotlightImageModel.h"

@interface EventImageIndexerTests : XCTestCase

@property (nonatomic, strong) EventImageIndexer *imageIndexer;
@property (nonatomic, strong) id mockSearchableIndex;
@property (nonatomic, strong) id mockObjectIndexer;

@end

@implementation EventImageIndexerTests

- (void)setUp {
    [super setUp];
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    
    self.mockObjectIndexer = OCMClassMock([EventObjectIndexer class]);
    self.mockSearchableIndex = OCMClassMock([CSSearchableIndex class]);
    
    self.imageIndexer = [[EventImageIndexer alloc] init];
    self.imageIndexer.indexer = self.mockObjectIndexer;
    self.imageIndexer.searchableIndex = self.mockSearchableIndex;
}

- (void)tearDown {
    self.imageIndexer = nil;
    
    [self.mockSearchableIndex stopMocking];
    self.mockSearchableIndex = nil;
    
    [self.mockObjectIndexer stopMocking];
    self.mockObjectIndexer = nil;
    
    [MagicalRecord cleanUp];
    [super tearDown];
}

- (void)testThatImageIndexerObtainsImageModelsCorrectly {
    // given
    NSUInteger countEntities = 3;
    NSArray *objectModels = [self createObjectsInCoreDataWithCount:countEntities];
    
    // when
    NSArray<SpotlightImageModel *> *result = [self.imageIndexer obtainImageModels];
    
    // then
    XCTAssertEqual(result.count, countEntities);
    for (NSUInteger i = 0; i < countEntities; ++i) {
        SpotlightImageModel *imageModel = result[i];
        EventModelObject *objectModel = objectModels[i];
        XCTAssertEqualObjects(imageModel.imageLink, objectModel.imageUrl);
        XCTAssertEqualObjects(imageModel.entityId, objectModel.eventId);
    }
}

- (void)testThatImageIndexerUpdatesSearchableIndexCorrectly {
    // given
    NSUInteger countEntities = 1;
    NSArray *objectModels = [self createObjectsInCoreDataWithCount:countEntities];
    EventModelObject *event = [objectModels firstObject];
    CSSearchableItem *item = [CSSearchableItem new];
    OCMStub([self.mockObjectIndexer searchableItemForObject:event]).andReturn(item);
    
    // when
    [self.imageIndexer updateModelsForEntityIdentifier:event.eventId];
    
    // then
    OCMVerify();
    OCMVerify([self.mockSearchableIndex indexSearchableItems:@[item]
                                           completionHandler:OCMOCK_ANY]);
}

#pragma mark - Private methods 

- (NSArray *)createObjectsInCoreDataWithCount:(NSUInteger)count {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_rootSavingContext];
    [context performBlockAndWait:^{
        for (NSUInteger i = 0; i < count; ++i) {
        EventModelObject *event = [EventModelObject MR_createEntityInContext:context];
            NSString *text = [NSString stringWithFormat:@"%lu",(unsigned long)i];
            event.eventId = text;
            event.imageUrl = text;
        }
        [context MR_saveToPersistentStoreAndWait];
    }];
    return [EventModelObject MR_findAll];
}

@end
