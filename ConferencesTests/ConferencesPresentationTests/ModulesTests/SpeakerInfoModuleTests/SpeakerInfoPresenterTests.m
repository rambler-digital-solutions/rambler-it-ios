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

#import "SpeakerInfoPresenter.h"
#import "SpeakerInfoViewInput.h"
#import "SpeakerInfoInteractorInput.h"
#import "SpeakerInfoPresenterStateStorage.h"
#import "SpeakerPlainObject.h"
#import "SpeakerInfoRouterInput.h"
#import "LecturePlainObject.h"

@interface SpeakerInfoPresenterTests : XCTestCase

@property (nonatomic, strong) SpeakerInfoPresenter *presenter;
@property (nonatomic, strong) id interactorMock;
@property (nonatomic, strong) id viewMock;
@property (nonatomic, strong) id routerMock;

@end

@implementation SpeakerInfoPresenterTests

- (void)setUp {
    [super setUp];
    
    self.presenter = [SpeakerInfoPresenter new];
    self.interactorMock = OCMProtocolMock(@protocol(SpeakerInfoInteractorInput));
    self.viewMock = OCMProtocolMock(@protocol(SpeakerInfoViewInput));
    self.routerMock = OCMProtocolMock(@protocol(SpeakerInfoRouterInput));
    
    self.presenter.view = self.viewMock;
    self.presenter.interactor = self.interactorMock;
    self.presenter.router = self.routerMock;
}

- (void)tearDown {
    self.presenter = nil;
    [self.interactorMock stopMocking];
    self.interactorMock = nil;
    [self.viewMock stopMocking];
    self.viewMock = nil;
    
    self.routerMock = nil;
    
    [super tearDown];
}

#pragma mark - SpeakerInfoViewOutput

- (void)testSuccessSetupview {
    // gvien
    NSString *speakerId = @"23jk3";
    
    SpeakerInfoPresenterStateStorage *stateStorage = [SpeakerInfoPresenterStateStorage new];
    stateStorage.speakerId = speakerId;
    
    self.presenter.stateStorage = stateStorage;
    
    // when
    [self.presenter setupView];
    
    // then
    OCMVerify([self.interactorMock obtainSpeakerWithSpeakerId:speakerId]);
}

- (void)testThatPresenterOpensWebBrowserOnSocialMaterialTapEvent {
    // given
    NSURL *testUrl = [NSURL URLWithString:@"rambler.ru"];
    
    // when
    [self.presenter didTriggerSocialNetworkTapEventWithUrl:testUrl];
    
    // then
    OCMVerify([self.routerMock openWebBrowserModuleWithUrl:testUrl]);
}

- (void)testThatPresenterOpensLectureModuleOnLectureTapEvent {
    // given
    NSString *const kTestLectureId = @"1234";
    LecturePlainObject *lecture = [LecturePlainObject new];
    lecture.lectureId = kTestLectureId;
    
    // when
    [self.presenter didTriggerLectureTapEventWithLecture:lecture];
    
    // then
    OCMVerify([self.routerMock openLectureModuleWithLectureId:kTestLectureId]);
}

#pragma mark - SpeakerInfoModuleInput

- (void)testSuccessConfigureCurrentModuleWithSpeakerObjectId {
    // given
    NSString *speakerId = @"23jk3";
    
    SpeakerInfoPresenterStateStorage *stateStorage = [SpeakerInfoPresenterStateStorage new];
    self.presenter.stateStorage = stateStorage;
    
    // when
    [self.presenter configureCurrentModuleWithSpeakerId:speakerId];
    
    // then
    XCTAssert(stateStorage.speakerId == speakerId);
}

@end
