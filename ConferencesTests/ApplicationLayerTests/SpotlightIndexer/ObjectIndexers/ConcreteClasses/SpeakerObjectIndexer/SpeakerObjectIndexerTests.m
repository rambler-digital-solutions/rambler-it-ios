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

#import "SpeakerObjectIndexer.h"
#import "ObjectTransformer.h"
#import "SpeakerModelObject.h"

@interface SpeakerObjectIndexerTests : XCTestCase

@property (nonatomic, strong) SpeakerObjectIndexer *indexer;
@property (nonatomic, strong) id mockTransformer;
@property (nonatomic, strong) id mockIndex;

@end

@implementation SpeakerObjectIndexerTests

- (void)setUp {
    [super setUp];
    
    [self setupCoreDataStackForTests];
    
    self.mockTransformer = OCMProtocolMock(@protocol(ObjectTransformer));
    self.mockIndex = OCMClassMock([CSSearchableIndex class]);
    
    self.indexer = [[SpeakerObjectIndexer alloc] initWithObjectTransformer:self.mockTransformer
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
    NSString *testObjectType = NSStringFromClass([SpeakerModelObject class]);
    
    // when
    BOOL result = [self.indexer canIndexObjectWithType:testObjectType];
    
    // then
    XCTAssertTrue(result);
}

- (void)testThatIndexerReturnsSearchableItem {
    // given
    NSString *const kTestSpeakerName = @"Стас Цыганов";
    
    SpeakerModelObject *speaker = [self generateSpeakerForTestPurposesWithName:kTestSpeakerName];
    
    // when
    CSSearchableItem *result = [self.indexer searchableItemForObject:speaker];
    
    // then
    XCTAssertEqualObjects(result.attributeSet.title, kTestSpeakerName);
    XCTAssertEqualObjects(result.attributeSet.contentDescription, @"");
}

- (void)testThatIndexerReturnsSearchableItemWithNameAndCompanyIfAvailable {
    // given
    NSString *const kTestSpeakerName = @"Стас Цыганов";
    NSString *const kTestSpeakerJob = @"iOS разработчик";
    NSString *const kTestSpeakerCompany = @"Rambler&Co";
    NSString *const kExpectedResult = @"iOS разработчик @ Rambler&Co";
    
    SpeakerModelObject *speaker = [self generateSpeakerForTestPurposesWithName:kTestSpeakerName];
    speaker.job = kTestSpeakerJob;
    speaker.company = kTestSpeakerCompany;
    
    // when
    CSSearchableItem *result = [self.indexer searchableItemForObject:speaker];
    
    // then
    XCTAssertEqualObjects(result.attributeSet.contentDescription, kExpectedResult);
}

- (void)testThatIndexerReturnsSearchableItemWithBio {
    // given
    NSString *const kTestSpeakerName = @"Стас Цыганов";
    NSString *const kTestSpeakerBio = @"Работаю давно, нормально";
    
    SpeakerModelObject *speaker = [self generateSpeakerForTestPurposesWithName:kTestSpeakerName];
    speaker.biography = kTestSpeakerBio;
    
    // when
    CSSearchableItem *result = [self.indexer searchableItemForObject:speaker];
    
    // then
    XCTAssertEqualObjects(result.attributeSet.contentDescription, kTestSpeakerBio);
}

- (void)testThatIndexerReturnsSearchableItemWithProperKeywords {
    // given
    NSString *const kTestSpeakerFirstName = @"Стас";
    NSString *const kTestSpeakerLastName = @"Стас";
    NSString *speakerName = [NSString stringWithFormat:@"%@ %@", kTestSpeakerFirstName, kTestSpeakerLastName];
    NSString *const kTestSpeakerCompany = @"Rambler&Co";
    
    SpeakerModelObject *speaker = [self generateSpeakerForTestPurposesWithName:speakerName];
    speaker.company = kTestSpeakerCompany;
    
    // when
    CSSearchableItem *result = [self.indexer searchableItemForObject:speaker];
    NSArray *keywords = result.attributeSet.keywords;
    
    // then
    BOOL includesFirstName = [keywords containsObject:kTestSpeakerFirstName];
    BOOL includesLastName = [keywords containsObject:kTestSpeakerLastName];
    BOOL includesCompany = [keywords containsObject:kTestSpeakerCompany];
    XCTAssertTrue(includesFirstName);
    XCTAssertTrue(includesLastName);
    XCTAssertTrue(includesCompany);
}

#pragma mark - Helper methods

- (SpeakerModelObject *)generateSpeakerForTestPurposesWithName:(NSString *)name {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    __block SpeakerModelObject *speaker = nil;
    [rootSavingContext performBlockAndWait:^{
        speaker = [SpeakerModelObject MR_createEntityInContext:rootSavingContext];
        speaker.name = name;
        [rootSavingContext MR_saveToPersistentStoreAndWait];
    }];
    return speaker;
}

@end
