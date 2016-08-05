//
//  LectureServiceTests.m
//  Conferences
//
//  Created by k.zinovyev on 05.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MagicalRecord/MagicalRecord.h>
#import <OCMock/OCMock.h>

#import "LectureServiceImplementation.h"
#import "OperationScheduler.h"
#import "CompoundOperationBase.h"
#import "LectureModelObject.h"

@interface LectureServiceTests : XCTestCase

@property (strong, nonatomic) LectureServiceImplementation *lectureService;

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
