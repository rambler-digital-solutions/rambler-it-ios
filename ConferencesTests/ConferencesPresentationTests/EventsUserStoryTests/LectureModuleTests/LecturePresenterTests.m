//
//  LecturePresenterTests.m
//  Conferences
//
//  Created by Karpushin Artem on 27/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "LecturePresenter.h"
#import "LectureViewInput.h"
#import "LectureInteractorInput.h"
#import "LectureRouterInput.h"
#import "LecturePresenterStateStorage.h"
#import "LecturePlainObject.h"
#import "SpeakerPlainObject.h"

@interface LecturePresenterTests : XCTestCase

@property (nonatomic, strong) LecturePresenter *presenter;
@property (nonatomic, strong) LecturePresenterStateStorage *stateStorage;
@property (nonatomic, strong) id interactorMock;
@property (nonatomic, strong) id viewMock;
@property (nonatomic, strong) id routerMock;

@end

@implementation LecturePresenterTests

- (void)setUp {
    [super setUp];
    
    self.presenter = [LecturePresenter new];
    self.stateStorage = [LecturePresenterStateStorage new];
    self.interactorMock = OCMProtocolMock(@protocol(LectureInteractorInput));
    self.viewMock = OCMProtocolMock(@protocol(LectureViewInput));
    self.routerMock = OCMProtocolMock(@protocol(LectureRouterInput));
    
    self.presenter.interactor = self.interactorMock;
    self.presenter.stateStorage = self.stateStorage;
    self.presenter.view = self.viewMock;
    self.presenter.router = self.routerMock;
}

- (void)tearDown {
    self.presenter = nil;
    self.stateStorage = nil;
    [self.interactorMock stopMocking];
    self.interactorMock = nil;
    [self.viewMock stopMocking];
    self.viewMock = nil;
    [self.routerMock stopMocking];
    self.routerMock = nil;
    
    [super tearDown];
}

#pragma mark - LectureViewOutput

- (void)testSuccessSetupView {
    // given
    NSString *objectId = @"3rj3332w";
    self.stateStorage.lectureObjectId = objectId;
    
    // when
    [self.presenter setupView];
    
    // then
    OCMVerify([self.interactorMock obtainLectureWithObjectId:objectId]);
}

- (void)testSuccessDidTapTableViewHeader {
    // given
    NSString *objectId = @"3rj3332w";
    self.stateStorage.speakerObjectId = objectId;
    
    // when
    [self.presenter didTapTableViewHeader];
    
    // then
    OCMVerify([self.routerMock openSpeakerInfoModuleWithSpeakerObjectId:objectId]);
}

#pragma mark - LectureInteractorOutput

- (void)testSuccessDidObtainLecture {
    // given
    NSString *objectId = @"3rj3332w";
    
    SpeakerPlainObject *speaker = [SpeakerPlainObject new];
    speaker.objectId = objectId;
    
    LecturePlainObject *lecture = [LecturePlainObject new];
    lecture.speakers = @[speaker];
    
    // when
    [self.presenter didObtainLecture:lecture];
    
    // then
    XCTAssert(self.stateStorage.speakerObjectId == objectId);
    OCMVerify([self.viewMock configureViewWithLecture:lecture]);
}

#pragma mark - LectureModuleInput

- (void)testSuccessConfigureCurrentModuleWithLectureObjectId {
    // given
    NSString *objectId = @"3rj3332w";
    
    // when
    [self.presenter configureCurrentModuleWithLectureObjectId:objectId];
    
    // then
    XCTAssert(self.stateStorage.lectureObjectId == objectId);
}

@end
