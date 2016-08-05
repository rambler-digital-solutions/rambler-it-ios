//
//  LectureInteractorTests.m
//  Conferences
//
//  Created by Karpushin Artem on 27/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "LectureInteractor.h"
#import "LectureInteractorOutput.h"
#import "ROSPonsomizer.h"
#import "LectureService.h"

@interface LectureInteractorTests : XCTestCase

@property (nonatomic, strong) LectureInteractor *interactor;
@property (nonatomic, strong) id mockPresenter;
@property (nonatomic, strong) id mockPonsomizer;
@property (nonatomic, strong) id mockLectureService;

@end

@implementation LectureInteractorTests

- (void)setUp {
    [super setUp];
    
    self.interactor = [LectureInteractor new];
    self.mockPresenter = OCMProtocolMock(@protocol(LectureInteractorOutput));
    self.mockPonsomizer = OCMProtocolMock(@protocol(ROSPonsomizer));
    self.mockLectureService = OCMProtocolMock(@protocol(LectureService));
    
    self.interactor.output = self.mockPresenter;
    self.interactor.ponsomizer = self.mockPonsomizer;
    self.interactor.lectureService = self.mockLectureService;
}

- (void)tearDown {
    self.interactor = nil;
    [self.mockPresenter stopMocking];
    self.mockPresenter = nil;
    self.mockPonsomizer = nil;
    self.mockLectureService = nil;
    
    [super tearDown];
}

#pragma mark - LectureInteractorInput

/**
 @author Artem Karpushin
 
 TODO: need to complete the test after service for lectures will get ready
 */
- (void)testSuccessObtainLectureWithObjectId {
    // given
    NSString *lectureId = @"0";
    id lectureManagedObject = @1;
    id lecturePlainObject = @2;
    
    OCMStub([self.mockLectureService obtainLectureWithLectureId:lectureId]).andReturn(lectureManagedObject);
    OCMStub([self.mockPonsomizer convertObject:lectureManagedObject]).andReturn(lecturePlainObject);
    
    // when
    id resultLecture = [self.interactor obtainLectureWithObjectId:lectureId];
    
    // then
    OCMVerify([self.mockLectureService obtainLectureWithLectureId:lectureId]);
    OCMVerify([self.mockPonsomizer convertObject:lectureManagedObject]);
    XCTAssertEqualObjects(resultLecture, lecturePlainObject);
}

@end
