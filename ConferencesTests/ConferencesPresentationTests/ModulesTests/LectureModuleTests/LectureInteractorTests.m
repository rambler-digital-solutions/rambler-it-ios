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
#import <OCMock/OCMock.h>

#import "LectureInteractor.h"
#import "LectureInteractorOutput.h"
#import "ROSPonsomizer.h"
#import "ShareUrlBuilder.h"
#import "LectureService.h"
#import "LecturePlainObject.h"
#import "YouTubeIdentifierDeriviator.h"
#import "LectureMaterialService.h"
#import "LectureMaterialPlainObject.h"

@interface LectureInteractorTests : XCTestCase

@property (nonatomic, strong) LectureInteractor *interactor;
@property (nonatomic, strong) id mockPresenter;
@property (nonatomic, strong) id mockPonsomizer;
@property (nonatomic, strong) id mockLectureService;
@property (nonatomic, strong) id mockLectureMaterialService;
@property (nonatomic, strong) id mockUrlBuilder;
@property (nonatomic, strong) id mockDeriviator;

@end

@implementation LectureInteractorTests

- (void)setUp {
    [super setUp];
    
    self.interactor = [LectureInteractor new];
    self.mockPresenter = OCMProtocolMock(@protocol(LectureInteractorOutput));
    self.mockPonsomizer = OCMProtocolMock(@protocol(ROSPonsomizer));
    self.mockLectureService = OCMProtocolMock(@protocol(LectureService));
    self.mockUrlBuilder = OCMProtocolMock(@protocol(ShareUrlBuilder));
    self.mockLectureMaterialService = OCMProtocolMock(@protocol(LectureMaterialService));
    self.mockDeriviator = OCMClassMock([YouTubeIdentifierDeriviator class]);
    
    self.interactor.output = self.mockPresenter;
    self.interactor.ponsomizer = self.mockPonsomizer;
    self.interactor.lectureService = self.mockLectureService;
    self.interactor.shareUrlBuilder = self.mockUrlBuilder;
    self.interactor.deriviator = self.mockDeriviator;
    self.interactor.lectureMaterialService = self.mockLectureMaterialService;
}

- (void)tearDown {
    self.interactor = nil;
    [self.mockPresenter stopMocking];
    self.mockPresenter = nil;
    
    [self.mockDeriviator stopMocking];
    self.mockDeriviator = nil;
    
    self.mockPonsomizer = nil;
    self.mockLectureService = nil;
    self.mockUrlBuilder = nil;
    self.mockLectureMaterialService = nil;
    
    [super tearDown];
}

#pragma mark - LectureInteractorInput

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

- (void)testThatInteractorReturnsActivityItems {
    // given
    NSURL *testUrl = [NSURL URLWithString:@"rambler.ru"];
    LecturePlainObject *lecture = [LecturePlainObject new];
    OCMStub([self.mockUrlBuilder buildShareUrlWithItemId:OCMOCK_ANY]).andReturn(testUrl);
    
    // when
    NSArray *result = [self.interactor obtainActivityItemsForLecture:lecture];
    
    // then
    XCTAssertEqualObjects([result firstObject], testUrl);
}

- (void)testThatInteractorDetectsYouTube {
    // given
    NSString *testUrlString = @"youtu.be/1234";
    NSURL *testUrl = [NSURL URLWithString:testUrlString];
    
    // when
    BOOL result = [self.interactor checkIfVideoIsFromYouTube:testUrl];
    
    // then
    OCMVerify([self.mockDeriviator checkIfVideoIsFromYouTube:testUrl]);
}

- (void)testThatInteractorDetectsNonYouTube {
    // given
    NSString *testUrlString = @"rambler.ru/1234";
    NSURL *testUrl = [NSURL URLWithString:testUrlString];
    
    // when
    BOOL result = [self.interactor checkIfVideoIsFromYouTube:testUrl];
    
    // then
    XCTAssertFalse(result);
}

- (void)testThatInteractorDerivesYouTubeIdentifier {
    // given
    NSString *testUrlString = @"rambler.ru/1234";
    NSString *identifier = @"abcd";
    NSURL *testUrl = [NSURL URLWithString:testUrlString];
    
    OCMStub([self.mockDeriviator deriveIdentifierFromUrl:testUrl]).andReturn(identifier);
    
    // when
    NSString *result = [self.interactor deriveVideoIdFromYouTubeUrl:testUrl];
    
    // then
    XCTAssertEqualObjects(result, identifier);
}

- (void)testThatInteractorDownloadLectureMaterial {
    // given
    NSString *materialId = @"materialId";
    
    // when
    [self.interactor downloadVideoToCacheWithLectureMaterialId:materialId];
    
    // then
    OCMVerify([self.mockLectureMaterialService downloadToCacheLectureMaterialId:materialId
                                                                       delegate:self.interactor]);
}

- (void)testThatInteractorRemoveLectureMaterial {
    // given
    NSString *materialId = @"materialId";
    
    // when
    [self.interactor removeVideoFromCacheWithLectureMaterialId:materialId];
    
    // then
    OCMVerify([self.mockLectureMaterialService removeFromCacheLectureMaterialId:materialId
                                                                     completion:OCMOCK_ANY]);
}

- (void)testThatInteractorUpdateDownloadingDelegateForLectureMaterials {
    // given
    LectureMaterialPlainObject *plain = [LectureMaterialPlainObject new];
    plain.lectureMaterialId = @"materialId";
    
    // when
    [self.interactor updateDownloadingDelegateWithLectureMaterials:@[plain]];
    
    // then
    OCMVerify([self.mockLectureMaterialService updateDelegate:self.interactor
                                         forLectureMaterialId:plain.lectureMaterialId]);
}

@end
