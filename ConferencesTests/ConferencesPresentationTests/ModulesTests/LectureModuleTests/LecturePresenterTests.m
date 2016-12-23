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
#import "OCMockObject+ProtocolsMock.h"
#import "LecturePresenter.h"
#import "LectureViewInput.h"
#import "LectureInteractorInput.h"
#import "LectureRouterInput.h"
#import "LecturePresenterStateStorage.h"
#import "LecturePlainObject.h"
#import "SpeakerPlainObject.h"
#import "LectureMaterialViewModel.h"
#import "LectureViewModelMapper.h"
#import "LectureViewModel.h"

@interface LecturePresenterTests : XCTestCase

@property (nonatomic, strong) LecturePresenter *presenter;
@property (nonatomic, strong) LecturePresenterStateStorage *stateStorage;
@property (nonatomic, strong) id interactorMock;
@property (nonatomic, strong) id viewMock;
@property (nonatomic, strong) id routerMock;
@property (nonatomic, strong) id mockLectureViewModelMapper;

@end

@implementation LecturePresenterTests

- (void)setUp {
    [super setUp];
    
    self.presenter = [LecturePresenter new];
    self.stateStorage = [LecturePresenterStateStorage new];
    self.interactorMock = OCMProtocolMock(@protocol(LectureInteractorInput));
    self.viewMock = OCMProtocolMock(@protocol(LectureViewInput));
    self.routerMock = OCMProtocolMock(@protocol(LectureRouterInput));
    self.mockLectureViewModelMapper = OCMClassMock([LectureViewModelMapper class]);
    
    self.presenter.interactor = self.interactorMock;
    self.presenter.stateStorage = self.stateStorage;
    self.presenter.view = self.viewMock;
    self.presenter.router = self.routerMock;
    self.presenter.mapperLectureViewModel = self.mockLectureViewModelMapper;
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
    
    [self.mockLectureViewModelMapper stopMocking];
    self.mockLectureViewModelMapper = nil;
    
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
    LectureViewModel *viewModel = [LectureViewModel new];
    OCMStub([self.mockLectureViewModelMapper mapLectureViewModelFromLecturePlainObject:lecture]).andReturn(viewModel);
    OCMStub([self.interactorMock obtainLectureWithObjectId:OCMOCK_ANY]).andReturn(lecture);

    // when
    [self.presenter setupView];
    
    // then
    XCTAssert(self.stateStorage.speakerObjectId == speakerObjectId);
    OCMVerify([self.viewMock configureViewWithLecture:viewModel]);
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

- (void)testSuccessDidTapCachedVideoPreview {
    // given
    LectureMaterialViewModel *model = [LectureMaterialViewModel new];
    id testUrl = @"rambler.ru";
    model.localURL = testUrl;
    
    // when
    [self.presenter didTapVideoPreviewWithVideoMaterial:model];
    
    // then
    OCMVerify([self.routerMock openLocalVideoPlayerModuleWithPath:testUrl]);
}

- (void)testSuccessDidTapYouTubeVideoPreview {
    // given
    LectureMaterialViewModel *model = [LectureMaterialViewModel new];
    NSString *link = @"rambler.ru";
    id testUrl = [NSURL URLWithString:link];
    model.link = link;
    NSString *testIdentifier = @"1234";
    OCMStub([self.interactorMock checkIfVideoIsFromYouTube:testUrl]).andReturn(YES);
    OCMStub([self.interactorMock deriveVideoIdFromYouTubeUrl:testUrl]).andReturn(testIdentifier);
    
    // when
    [self.presenter didTapVideoPreviewWithVideoMaterial:model];
    
    // then
    OCMVerify([self.routerMock openYouTubeVideoPlayerModuleWithIdentifier:testIdentifier]);
}

- (void)testSuccessTapOtherVideoPreview {
    // given
    LectureMaterialViewModel *model = [LectureMaterialViewModel new];
    NSString *link = @"rambler.ru";
    id testUrl = [NSURL URLWithString:link];
    model.link = link;
    OCMStub([self.interactorMock checkIfVideoIsFromYouTube:testUrl]).andReturn(NO);
    
    // when
    [self.presenter didTapVideoPreviewWithVideoMaterial:model];
    
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

- (void)testThatPresenterRemoveCacheMaterialCorrectly {
    // given
    LectureMaterialViewModel *model = [LectureMaterialViewModel new];
    
    // when
    [self.presenter didTapRemoveFromCacheLectureMaterial:model];
    
    // then
    OCMVerify([self.routerMock showAlertConfirmationRemoveWithActionBlock:OCMOCK_ANY]);
}

- (void)testThatPresenterDownloadToCacheMaterialCorrectly {
    // given
    LectureMaterialViewModel *model = [LectureMaterialViewModel new];
    
    // when
    [self.presenter didTapDownloadToCacheLectureMaterial:model];
    
    // then
    OCMVerify([self.routerMock showAlertConfirmationDownloadWithActionBlock:OCMOCK_ANY]);
}

- (void)testThatPresenterUpdateLectureMaterialCorrectly {
    // given
    
    // when
    [self.presenter didTriggerCacheOperationWithType:LectureMaterialStartDownloadType
                                     lectureMaterial:OCMOCK_ANY
                                             percent:0];
    
    // then
    OCMVerify([self.viewMock updateViewWithLectureMaterial:OCMOCK_ANY]);
}

- (void)testThatPresenterOccurErrorCorrectly {
    // given
    id error = OCMClassMock([NSError class]);
    NSString *localizedDescription = @"";
    OCMStub([error localizedDescription]).andReturn(localizedDescription);
    
    // when
    [self.presenter didOccurError:error];
    
    // then
    OCMVerify([self.routerMock showAlertErrorWithMessage:localizedDescription]);
    
}

- (void)testThatPresenterOccurErrorIfNilCorrectly {
    // given
    id error = nil;
    
    // when
    [self.presenter didOccurError:error];
    
    // then
    OCMVerify([self.routerMock showAlertErrorWithMessage:nil]);
}

- (void)testThatPresenterDidTriggerViewWillAppearCorrectly {
    // given
    self.stateStorage.lectureObjectId = @"id";
    
    // when
    [self.presenter didTriggerViewWillAppear];
    
    // then
    OCMVerify([self.interactorMock obtainLectureWithObjectId:self.stateStorage.lectureObjectId]);
    OCMVerify([self.interactorMock updateDownloadingDelegateWithLectureMaterials:OCMOCK_ANY]);
}

@end
