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
#import "LectureImageIndexer.h"
#import "LectureObjectIndexer.h"
#import "LectureModelObject.h"
#import "LectureMaterialModelObject.h"
#import "SpotlightImageModel.h"
#import "LectureMaterialType.h"
#import "VideoThumbnailGenerator.h"

@interface LectureImageIndexerTests : XCTestCase

@property (nonatomic, strong) LectureImageIndexer *imageIndexer;
@property (nonatomic, strong) id mockSearchableIndex;
@property (nonatomic, strong) id mockObjectIndexer;
@property (nonatomic, strong) id mockIdentifierGenerator;

@end

@implementation LectureImageIndexerTests

- (void)setUp {
    [super setUp];
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    
    self.mockObjectIndexer = OCMClassMock([LectureObjectIndexer class]);
    self.mockSearchableIndex = OCMClassMock([CSSearchableIndex class]);
    self.mockIdentifierGenerator = OCMClassMock([VideoThumbnailGenerator class]);
    
    self.imageIndexer = [[LectureImageIndexer alloc] init];
    self.imageIndexer.indexer = self.mockObjectIndexer;
    self.imageIndexer.searchableIndex = self.mockSearchableIndex;
    self.imageIndexer.videoThumbnailGenerator = self.mockIdentifierGenerator;
}

- (void)tearDown {
    self.imageIndexer = nil;
    
    [self.mockSearchableIndex stopMocking];
    self.mockSearchableIndex = nil;
    
    [self.mockObjectIndexer stopMocking];
    self.mockObjectIndexer = nil;
    
    [self.mockIdentifierGenerator stopMocking];
    self.mockIdentifierGenerator = nil;
    
    [MagicalRecord cleanUp];
    [super tearDown];
}

- (void)testThatImageIndexerObtainsImageModelsCorrectly {
    // given
    NSUInteger countEntities = 1;
    NSString *imageLink = @"imageLink";
    NSURL *url = [NSURL URLWithString:imageLink];
    NSArray *objectModels = [self createObjectsInCoreDataWithCount:countEntities];
    OCMStub([self.mockIdentifierGenerator generateThumbnailWithVideoURL:OCMOCK_ANY]).andReturn(url);
    
    // when
    NSArray<SpotlightImageModel *> *result = [self.imageIndexer obtainImageModels];
    
    // then
    XCTAssertEqual(result.count, countEntities);
    for (NSUInteger i = 0; i < countEntities; ++i) {
        SpotlightImageModel *imageModel = result[i];
        LectureModelObject *objectModel = objectModels[i];
        XCTAssertEqualObjects(imageModel.imageLink, imageLink);
        XCTAssertEqualObjects(imageModel.entityId, objectModel.lectureId);
    }
}

- (void)testThatImageIndexerUpdatesSearchableIndexCorrectly {
    // given
    NSUInteger countEntities = 1;
    NSArray *objectModels = [self createObjectsInCoreDataWithCount:countEntities];
    LectureModelObject *lecture = [objectModels firstObject];
    CSSearchableItem *item = [CSSearchableItem new];
    OCMStub([self.mockObjectIndexer searchableItemForObject:lecture]).andReturn(item);
    
    // when
    [self.imageIndexer updateModelsForEntityIdentifier:lecture.lectureId];
    
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
            LectureModelObject *lecture = [LectureModelObject MR_createEntityInContext:context];
            NSString *text = [NSString stringWithFormat:@"%lu",(unsigned long)i];
            lecture.lectureId = text;
            LectureMaterialModelObject *material = [LectureMaterialModelObject MR_createEntityInContext:context];
            material.link = @"https://rambler-co.ru";
            material.type = @(LectureMaterialVideoType);
            lecture.lectureMaterials = [NSSet setWithObject:material];
        }
        [context MR_saveToPersistentStoreAndWait];
    }];
    return [LectureModelObject MR_findAll];
}

@end
