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

#import "XCTestCase+RCFHelpers.h"

#import "LectureObjectTransformer.h"
#import "LectureModelObject.h"

@interface LectureObjectTransformerTests : XCTestCase

@property (nonatomic, strong) LectureObjectTransformer *transformer;

@end

@implementation LectureObjectTransformerTests

- (void)setUp {
    [super setUp];
    
    [self setupCoreDataStackForTests];
    
    self.transformer = [LectureObjectTransformer new];
}

- (void)tearDown {
    self.transformer = nil;
    
    [self tearDownCoreDataStack];
    
    [super tearDown];
}

- (void)testThatTransformerReturnsIdentifierForLecture {
    // given
    NSString *const kTestLectureId = @"1234";
    LectureModelObject *lecture = [self generateLectureForTestPurposesWithId:kTestLectureId];
    
    // when
    NSString *identifier = [self.transformer identifierForObject:lecture];
    
    // then
    BOOL hasLectureId = [identifier rangeOfString:kTestLectureId].location != NSNotFound;
    BOOL hasObjectType = [identifier rangeOfString:NSStringFromClass([LectureModelObject class])].location != NSNotFound;
    
    XCTAssertNotNil(identifier);
    XCTAssertTrue(hasLectureId);
    XCTAssertTrue(hasObjectType);
}

- (void)testThatTransformerReturnsLectureForIdentifier {
    // given
    NSString *const kTestLectureId = @"1234";
    NSString *const kTestIdentifier = @"LectureModelObject_1234";
    [self generateLectureForTestPurposesWithId:kTestLectureId];
    
    // when
    LectureModelObject *lecture = [self.transformer objectForIdentifier:kTestIdentifier];
    
    // then
    XCTAssertEqualObjects(lecture.lectureId, kTestLectureId);
}

- (void)testThatTransformerDetectsCorrectIdentifier {
    // given
    NSString *const kTestIdentifier = @"LectureModelObject_1234";
    
    // when
    BOOL result = [self.transformer isCorrectIdentifier:kTestIdentifier];
    
    // then
    XCTAssertTrue(result);
}

- (void)testThatTransformerDetectsIncorrectIdentifier {
    // given
    NSString *const kTestIdentifier = @"1234";
    
    // when
    BOOL result = [self.transformer isCorrectIdentifier:kTestIdentifier];
    
    // then
    XCTAssertFalse(result);
}

#pragma mark - Helper methods

- (LectureModelObject *)generateLectureForTestPurposesWithId:(NSString *)lectureId {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    __block LectureModelObject *object = nil;
    [rootSavingContext performBlockAndWait:^{
        object = [LectureModelObject MR_createEntityInContext:rootSavingContext];
        object.lectureId = lectureId;
        
        [rootSavingContext MR_saveOnlySelfAndWait];
    }];
    return object;
}

@end
