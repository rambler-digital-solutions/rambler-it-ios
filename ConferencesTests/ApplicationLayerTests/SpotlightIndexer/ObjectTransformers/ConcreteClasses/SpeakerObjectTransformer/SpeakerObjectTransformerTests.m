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

#import "SpeakerObjectTransformer.h"
#import "SpeakerModelObject.h"

@interface SpeakerObjectTransformerTests : XCTestCase

@property (nonatomic, strong) SpeakerObjectTransformer *transformer;

@end

@implementation SpeakerObjectTransformerTests

- (void)setUp {
    [super setUp];
    
    [self setupCoreDataStackForTests];
    
    self.transformer = [SpeakerObjectTransformer new];
}

- (void)tearDown {
    self.transformer = nil;
    
    [self tearDownCoreDataStack];
    
    [super tearDown];
}

- (void)testThatTransformerReturnsIdentifierForSpeaker {
    // given
    NSString *const kTestSpeakerId = @"1234";
    SpeakerModelObject *speaker = [self generateSpeakerForTestPurposesWithId:kTestSpeakerId];
    
    // when
    NSString *identifier = [self.transformer identifierForObject:speaker];
    
    // then
    BOOL hasSpeakerId = [identifier rangeOfString:kTestSpeakerId].location != NSNotFound;
    BOOL hasObjectType = [identifier rangeOfString:NSStringFromClass([SpeakerModelObject class])].location != NSNotFound;
    
    XCTAssertNotNil(identifier);
    XCTAssertTrue(hasSpeakerId);
    XCTAssertTrue(hasObjectType);
}

- (void)testThatTransformerReturnsSpeakerForIdentifier {
    // given
    NSString *const kTestSpeakerId = @"1234";
    NSString *const kTestIdentifier = @"SpeakerModelObject_1234";
    [self generateSpeakerForTestPurposesWithId:kTestSpeakerId];
    
    // when
    SpeakerModelObject *speaker = [self.transformer objectForIdentifier:kTestIdentifier];
    
    // then
    XCTAssertEqualObjects(speaker.speakerId, kTestSpeakerId);
}

- (void)testThatTransfornerDetectsCorrectIdentifier {
    // given
    NSString *const kTestIdentifier = @"SpeakerModelObject_1234";
    
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

- (SpeakerModelObject *)generateSpeakerForTestPurposesWithId:(NSString *)speakerId {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    __block SpeakerModelObject *object = nil;
    [rootSavingContext performBlockAndWait:^{
        object = [SpeakerModelObject MR_createEntityInContext:rootSavingContext];
        object.speakerId = speakerId;
        
        [rootSavingContext MR_saveOnlySelfAndWait];
    }];
    return object;
}

@end
