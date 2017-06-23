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

#import "SuggestServiceImplementation.h"

#import "EventModelObject.h"
#import "SpeakerModelObject.h"
#import "LectureModelObject.h"

@interface SuggestServiceImplementationTests : XCTestCase

@property (nonatomic, strong) SuggestServiceImplementation *service;

@end

@implementation SuggestServiceImplementationTests

- (void)setUp {
    [super setUp];
    
    [self setupCoreDataStackForTests];
    
    self.service = [SuggestServiceImplementation new];
}

- (void)tearDown {
    self.service = nil;
    
    [self tearDownCoreDataStack];
    
    [super tearDown];
}

- (void)testThatServiceObtainsRandomSuggests {
    // given
    [self generateModels];
    NSUInteger const kTestCount = 5;
    
    // when
    NSArray *result = [self.service obtainRandomSuggestsWithCount:kTestCount];
    
    // then
    XCTAssertEqual(result.count, kTestCount);
}

#pragma mark - Private methods

- (void)generateModels {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    [rootSavingContext performBlockAndWait:^{
        for (NSUInteger i = 0; i < 100; i++) {
            EventModelObject *event = [EventModelObject MR_createEntityInContext:rootSavingContext];
            event.name = [[NSUUID UUID] UUIDString];
            
            SpeakerModelObject *speaker = [SpeakerModelObject MR_createEntityInContext:rootSavingContext];
            speaker.name = [[NSUUID UUID] UUIDString];
            
            LectureModelObject *lecture = [LectureModelObject MR_createEntityInContext:rootSavingContext];
            lecture.name = [[NSUUID UUID] UUIDString];
        }
        
        [rootSavingContext MR_saveToPersistentStoreAndWait];
    }];
}

@end
