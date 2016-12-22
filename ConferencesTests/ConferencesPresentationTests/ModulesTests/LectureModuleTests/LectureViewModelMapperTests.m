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
#import "LectureViewModelMapper.h"
#import "LecturePlainObject.h"
#import "SpeakerPlainObject.h"
#import "LectureViewModel.h"

@interface LectureViewModelMapperTests : XCTestCase

@property (nonatomic, strong) LectureViewModelMapper *mapper;

@end

@implementation LectureViewModelMapperTests

- (void)setUp {
    [super setUp];
    
    self.mapper = [[LectureViewModelMapper alloc] init];
}

- (void)tearDown {
    self.mapper = nil;
    
    [super tearDown];
}

- (void)testThatMapperCreateLectureViewModelCorrectly {
    // given
    LecturePlainObject *plain = [LecturePlainObject new];
    plain.lectureId = @"lectureId";
    plain.name = @"name";
    plain.speaker = [SpeakerPlainObject new];
    plain.tags = [NSSet new];
    plain.lectureMaterials = [NSSet new];
    plain.lectureDescription = @"lectureDescription";
    
    // when
    LectureViewModel *result = [self.mapper mapLectureViewModelFromLecturePlainObject:plain];
    
    // then
    XCTAssertEqualObjects(result.name, plain.name);
    XCTAssertEqualObjects(result.lectureId, plain.lectureId);
    XCTAssertEqualObjects(result.speaker, plain.speaker);
    XCTAssertEqualObjects(result.tags, plain.tags);
    XCTAssertEqualObjects(result.lectureMaterials, plain.name);
    XCTAssertEqualObjects(result.lectureDescription, plain.lectureDescription);
}

@end
