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
    NSString *speakerObjectId = @"3rj3332w";
    
    SpeakerPlainObject *speaker = [SpeakerPlainObject new];
    speaker.objectId = speakerObjectId;
    
    LecturePlainObject *lecture = [LecturePlainObject new];
    lecture.speakers = @[speaker];
    
    OCMStub([self.interactorMock obtainLectureWithObjectId:OCMOCK_ANY]).andReturn(lecture);
    
    // when
    [self.presenter setupView];
    
    // then
    XCTAssert(self.stateStorage.speakerObjectId == speakerObjectId);
    OCMVerify([self.viewMock configureViewWithLecture:lecture]);
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

- (void)testSuccessDidTapShareButton {
    // given
    NSArray *activityItems = @[];
    LecturePlainObject *lecture = [LecturePlainObject new];
    
    OCMStub([self.interactorMock obtainLectureWithObjectId:OCMOCK_ANY]).andReturn(lecture);
    OCMStub([self.interactorMock obtainActivityItemsForLecture:lecture]).andReturn(activityItems);
    
    // when
    [self.presenter didTapShareButton];
    
    // then
    OCMVerify([self.routerMock openShareModuleWithActivityItems:activityItems]);
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
