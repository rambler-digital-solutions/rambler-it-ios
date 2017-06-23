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
#import <MagicalRecord/MagicalRecord.h>

#import "XCTestCase+RCFHelpers.h"

#import "LectureObjectIndexer.h"
#import "ObjectTransformer.h"
#import "LectureModelObject.h"
#import "TagModelObject.h"

@interface LectureObjectIndexerTests : XCTestCase

@property (nonatomic, strong) LectureObjectIndexer *indexer;
@property (nonatomic, strong) id mockTransformer;
@property (nonatomic, strong) id mockIndex;

@end

@implementation LectureObjectIndexerTests

- (void)setUp {
    [super setUp];
    
    [self setupCoreDataStackForTests];
    
    self.mockTransformer = OCMProtocolMock(@protocol(ObjectTransformer));
    self.mockIndex = OCMClassMock([CSSearchableIndex class]);
    
    self.indexer = [[LectureObjectIndexer alloc] initWithObjectTransformer:self.mockTransformer
                                                           searchableIndex:self.mockIndex];
}

- (void)tearDown {
    self.indexer = nil;
    self.mockTransformer = nil;
    
    [self.mockIndex stopMocking];
    self.mockIndex = nil;
    
    [self tearDownCoreDataStack];
    
    [super tearDown];
}

- (void)testThatIndexerCanIndexEvent {
    // given
    NSString *testObjectType = NSStringFromClass([LectureModelObject class]);
    
    // when
    BOOL result = [self.indexer canIndexObjectWithType:testObjectType];
    
    // then
    XCTAssertTrue(result);
}

- (void)testThatIndexerReturnsSearchableItem {
    // given
    NSString *const kTestLectureName = @"Feature Toggles в iOS";
    NSString *const kTestLectureDescription = @"Доклад про if-else";
    NSString *const kTestTagName = @"iOS";
    
    LectureModelObject *lecture = [self generateLectureForTestPurposesWithName:kTestLectureName
                                                                   description:kTestLectureDescription
                                                                      tagNames:@[kTestTagName]];
    
    // when
    CSSearchableItem *result = [self.indexer searchableItemForObject:lecture];
    BOOL hasCorrectKeywords = [result.attributeSet.keywords containsObject:kTestTagName];
    
    // then
    XCTAssertEqualObjects(result.attributeSet.title, kTestLectureName);
    XCTAssertEqualObjects(result.attributeSet.contentDescription, kTestLectureDescription);
    XCTAssertTrue(hasCorrectKeywords);
}

#pragma mark - Helper methods

- (LectureModelObject *)generateLectureForTestPurposesWithName:(NSString *)name
                                                   description:(NSString *)description
                                                      tagNames:(NSArray *)tagNames {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    __block LectureModelObject *lecture = nil;
    [rootSavingContext performBlockAndWait:^{
        lecture = [LectureModelObject MR_createEntityInContext:rootSavingContext];
        lecture.name = name;
        lecture.lectureDescription = description;
        
        for (NSString *tagName in tagNames) {
            TagModelObject *tag = [TagModelObject MR_createEntityInContext:rootSavingContext];
            tag.name = tagName;
            
            [lecture addTagsObject:tag];
        }
        
        [rootSavingContext MR_saveToPersistentStoreAndWait];
    }];
    return lecture;
}

@end
