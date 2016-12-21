// Copyright (c) 2016 RAMBLER&Co
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
#import <CoreSpotlight/CoreSpotlight.h>
#import <OCMock/OCMock.h>
#import <MagicalRecord/MagicalRecord.h>
#import "SpeakerImageIndexer.h"
#import "SpeakerObjectIndexer.h"
#import "SpeakerModelObject.h"
#import "SpotlightImageModel.h"

@interface SpeakerImageIndexerTests : XCTestCase

@property (nonatomic, strong) SpeakerImageIndexer *imageIndexer;
@property (nonatomic, strong) id mockSearchableIndex;
@property (nonatomic, strong) id mockObjectIndexer;

@end

@implementation SpeakerImageIndexerTests

- (void)setUp {
    [super setUp];
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    
    self.mockObjectIndexer = OCMClassMock([SpeakerObjectIndexer class]);
    self.mockSearchableIndex = OCMClassMock([CSSearchableIndex class]);
    
    self.imageIndexer = [[SpeakerImageIndexer alloc] init];
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
        SpeakerModelObject *objectModel = objectModels[i];
        XCTAssertEqualObjects(imageModel.imageLink, objectModel.imageUrl);
        XCTAssertEqualObjects(imageModel.entityId, objectModel.speakerId);
    }
}

- (void)testThatImageIndexerUpdatesSearchableIndexCorrectly {
    // given
    NSUInteger countEntities = 1;
    NSArray *objectModels = [self createObjectsInCoreDataWithCount:countEntities];
    SpeakerModelObject *speaker = [objectModels firstObject];
    CSSearchableItem *item = [CSSearchableItem new];
    OCMStub([self.mockObjectIndexer searchableItemForObject:speaker]).andReturn(item);
    
    // when
    [self.imageIndexer updateModelsForEntityIdentifier:speaker.speakerId];
    
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
            SpeakerModelObject *speaker = [SpeakerModelObject MR_createEntityInContext:context];
            NSString *text = [NSString stringWithFormat:@"%lu",(unsigned long)i];
            speaker.speakerId = text;
            speaker.imageUrl = text;
        }
        [context MR_saveToPersistentStoreAndWait];
    }];
    return [SpeakerModelObject MR_findAll];
}

@end
