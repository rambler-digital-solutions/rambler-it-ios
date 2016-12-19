//
//  LectureViewModelMapperTests.m
//  Conferences
//
//  Created by k.zinovyev on 19.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

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
