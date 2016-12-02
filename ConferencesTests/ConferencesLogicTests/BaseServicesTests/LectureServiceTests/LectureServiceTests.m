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
#import <MagicalRecord/MagicalRecord.h>
#import <OCMock/OCMock.h>

#import "LectureServiceImplementation.h"
#import "OperationScheduler.h"
#import "CompoundOperationBase.h"
#import "LectureModelObject.h"

@interface LectureServiceTests : XCTestCase

@property (nonatomic, strong) LectureServiceImplementation *lectureService;

@end

@implementation LectureServiceTests

- (void)setUp {
    [super setUp];
    
    [MagicalRecord setDefaultModelFromClass:[self class]];
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    
    self.lectureService = [LectureServiceImplementation new];
}

- (void)tearDown {
    [MagicalRecord cleanUp];
    
    self.lectureService = nil;
    
    [super tearDown];
}

- (void)testSuccessUpdateLectureWithPredicate {
    // given
    LectureModelObject *lecture = [LectureModelObject MR_createEntity];
    [MagicalRecord saveWithBlockAndWait:nil];
    NSArray *expectedLectures = @[lecture];
    
    // when
    NSArray *lectures = [self.lectureService obtainLectureWithPredicate:nil];
    
    // then
    XCTAssertEqualObjects(expectedLectures, lectures);
}

- (void)testSuccessUpdateLectureWithObjectId {
    // given
    NSString *lectureId = @"0";
    LectureModelObject *expectedLecture = [LectureModelObject MR_createEntity];
    expectedLecture.lectureId = lectureId;
    [MagicalRecord saveWithBlockAndWait:nil];
    
    // when
    LectureModelObject *lecture = [self.lectureService obtainLectureWithLectureId:lectureId];
    
    // then
    XCTAssertEqualObjects(expectedLecture, lecture);
}

@end
