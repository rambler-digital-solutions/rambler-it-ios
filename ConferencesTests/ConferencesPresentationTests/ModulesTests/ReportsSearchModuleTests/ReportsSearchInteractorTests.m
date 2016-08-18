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

#import "ReportsSearchInteractor.h"
#import "ReportsSearchInteractorOutput.h"

#import "EventService.h"
#import "SpeakerService.h"
#import "LectureService.h"
#import "EventTypeDeterminator.h"
#import "EventPlainObject.h"
#import "EventModelObject.h"
#import "ROSPonsomizer.h"

#import "XCTestCase+RCFHelpers.h"
#import "TestConstants.h"
typedef void (^ProxyBlock)(NSInvocation *);

@interface ReportsSearchInteractorTests : XCTestCase

@property (nonatomic, strong) ReportsSearchInteractor *interactor;
@property (nonatomic, strong) EventTypeDeterminator *mockEventTypeDeterminator;
@property (nonatomic, strong) id <ReportsSearchInteractorOutput> mockOutput;
@property (nonatomic, strong) id <EventService> mockEventService;
@property (nonatomic, strong) id <SpeakerService> mockSpeakerService;
@property (nonatomic, strong) id <LectureService> mockLectureService;
@property (nonatomic, strong) id <ROSPonsomizer> mockPonsomizer;

@end

@implementation ReportsSearchInteractorTests

- (void)setUp {
    [super setUp];
    
    self.interactor = [ReportsSearchInteractor new];
    self.mockOutput = OCMProtocolMock(@protocol(ReportsSearchInteractorOutput));
    self.mockEventService = OCMProtocolMock(@protocol(EventService));
    self.mockLectureService = OCMProtocolMock(@protocol(LectureService));
    self.mockSpeakerService = OCMProtocolMock(@protocol(SpeakerService));
    self.mockEventTypeDeterminator = OCMClassMock([EventTypeDeterminator class]);
    self.mockPonsomizer = OCMProtocolMock(@protocol(ROSPonsomizer));
    
    self.interactor.output = self.mockOutput;
    self.interactor.eventService = self.mockEventService;
    self.interactor.lectureService = self.mockLectureService;
    self.interactor.speakerService = self.mockSpeakerService;
    self.interactor.eventTypeDeterminator = self.mockEventTypeDeterminator;
    self.interactor.ponsomizer = self.mockPonsomizer;
}

- (void)tearDown {
    self.interactor = nil;
    self.mockOutput = nil;
    self.mockEventService = nil;
    self.mockSpeakerService = nil;
    self.mockLectureService = nil;
    self.mockEventTypeDeterminator = nil;
    self.mockPonsomizer = nil;

    [super tearDown];
}

- (void)testSuccessObtainEventList {
    // given
    
    NSArray *expectetObjects = @[@1, @2, @3];
    OCMStub([self.mockEventService obtainEventsWithPredicate:OCMOCK_ANY]).andReturn(@[@1]);
    OCMStub([self.mockSpeakerService obtainSpeakerWithPredicate:OCMOCK_ANY]).andReturn(@[@2]);
    OCMStub([self.mockLectureService obtainLectureWithPredicate:OCMOCK_ANY]).andReturn(@[@3]);
    
    OCMStub([self.mockPonsomizer convertObject:@[@1]]).andReturn(@[@1]);
    OCMStub([self.mockPonsomizer convertObject:@[@2]]).andReturn(@[@2]);
    OCMStub([self.mockPonsomizer convertObject:@[@3]]).andReturn(@[@3]);
    
    // when
    id result = [self.interactor obtainFoundObjectListWithSearchText:@""];
    
    // then
    XCTAssertEqualObjects(result, expectetObjects);
}

@end
