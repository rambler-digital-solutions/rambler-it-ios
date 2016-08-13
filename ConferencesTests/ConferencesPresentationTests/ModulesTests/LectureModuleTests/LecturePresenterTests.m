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
    speaker.speakerId = speakerObjectId;
    
    LecturePlainObject *lecture = [LecturePlainObject new];
    lecture.speaker = speaker;
    
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
    [self.presenter didTapSpeakerWithId:objectId];
    
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

- (void)testSuccessDidTapVideoPreview {
    // given
    NSURL *testUrl = [NSURL URLWithString:@"rambler.ru"];
    
    // when
    [self.presenter didTapVideoPreviewWithUrl:testUrl];
    
    // then
    OCMVerify([self.routerMock openWebBrowserModuleWithUrl:testUrl]);
}

- (void)testSuccessDidTapMaterial {
    // given
    NSURL *testUrl = [NSURL URLWithString:@"rambler.ru"];
    
    // when
    [self.presenter didTapMaterialWithUrl:testUrl];
    
    // then
    OCMVerify([self.routerMock openWebBrowserModuleWithUrl:testUrl]);
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
