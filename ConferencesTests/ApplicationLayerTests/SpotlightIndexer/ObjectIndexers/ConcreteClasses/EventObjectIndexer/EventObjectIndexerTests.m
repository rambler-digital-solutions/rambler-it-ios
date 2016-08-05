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

#import "EventObjectIndexer.h"
#import "ObjectTransformer.h"
#import "EventModelObject.h"
#import "LectureModelObject.h"
#import "TagModelObject.h"

@interface EventObjectIndexerTests : XCTestCase

@property (nonatomic, strong) EventObjectIndexer *indexer;
@property (nonatomic, strong) id mockTransformer;
@property (nonatomic, strong) id mockIndex;

@end

@implementation EventObjectIndexerTests

- (void)setUp {
    [super setUp];
    
    [self setupCoreDataStackForTests];
    
    self.mockTransformer = OCMProtocolMock(@protocol(ObjectTransformer));
    self.mockIndex = OCMClassMock([CSSearchableIndex class]);
    
    self.indexer = [[EventObjectIndexer alloc] initWithObjectTransformer:self.mockTransformer
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
    NSString *testObjectType = NSStringFromClass([EventModelObject class]);
    
    // when
    BOOL result = [self.indexer canIndexObjectWithType:testObjectType];
    
    // then
    XCTAssertTrue(result);
}

- (void)testThatIndexerReturnsSearchableItem {
    // given
    NSString *const kTestEventName = @"Rambler.iOS";
    NSString *const kTestLectureName = @"TDD в iOS";
    NSString *const kTestTagName = @"testing";
    
    EventModelObject *event = [self generateEventForTestPurposesWithName:kTestEventName
                                                             lectureName:kTestLectureName
                                                              lectureTag:kTestTagName];
    
    // when
    CSSearchableItem *result = [self.indexer searchableItemForObject:event];
    BOOL hasCorrectDescription = [result.attributeSet.contentDescription rangeOfString:kTestLectureName].location != NSNotFound;
    BOOL hasCorrectKeywords = [result.attributeSet.keywords containsObject:kTestTagName] &&
    [result.attributeSet.keywords containsObject:kTestEventName];
    
    // then
    XCTAssertEqualObjects(result.attributeSet.title, kTestEventName);
    XCTAssertTrue(hasCorrectDescription);
    XCTAssertTrue(hasCorrectKeywords);
}

#pragma mark - Helper methods

- (EventModelObject *)generateEventForTestPurposesWithName:(NSString *)eventName
                                               lectureName:(NSString *)lectureName
                                                lectureTag:(NSString *)lectureTag {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    __block EventModelObject *event = nil;
    [rootSavingContext performBlockAndWait:^{
        event = [EventModelObject MR_createEntityInContext:rootSavingContext];
        event.name = eventName;
        
        LectureModelObject *lecture = [LectureModelObject MR_createEntityInContext:rootSavingContext];
        lecture.name = lectureName;
        
        TagModelObject *tag = [TagModelObject MR_createEntityInContext:rootSavingContext];
        tag.name = lectureTag;
        
        [lecture addTagsObject:tag];
        [event addLecturesObject:lecture];
    }];
    return event;
}

@end
