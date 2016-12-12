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

#import "EventPlainObject.h"
#import "SpeakerPlainObject.h"
#import "LecturePlainObject.h"
#import "EventService.h"
#import "SpeakerService.h"
#import "LectureService.h"
#import "ROSPonsomizer.h"
#import "SearchFacadeImplementation.h"

@interface SearchFacadeTests : XCTestCase

@property (nonatomic, strong) SearchFacadeImplementation *searchFacade;
@property (nonatomic, strong) id <EventService> mockEventService;
@property (nonatomic, strong) id <SpeakerService> mockSpeakerService;
@property (nonatomic, strong) id <LectureService> mockLectureService;
@property (nonatomic, strong) id <ROSPonsomizer> mockPonsomizer;

@end

@implementation SearchFacadeTests

- (void)setUp {
    [super setUp];
    
    self.searchFacade = [SearchFacadeImplementation new];
    self.mockEventService = OCMStrictProtocolMock(@protocol(EventService));
    self.mockSpeakerService = OCMStrictProtocolMock(@protocol(SpeakerService));
    self.mockLectureService = OCMStrictProtocolMock(@protocol(LectureService));
    self.mockPonsomizer = OCMStrictProtocolMock(@protocol(ROSPonsomizer));
    
    self.searchFacade.eventService = self.mockEventService;
    self.searchFacade.speakerService = self.mockSpeakerService;
    self.searchFacade.lectureService = self.mockLectureService;
    self.searchFacade.ponsomizer = self.mockPonsomizer;
}

- (void)tearDown {
    self.searchFacade = nil;
    
    self.mockEventService = nil;
    self.mockSpeakerService = nil;
    self.mockLectureService = nil;
    self.mockPonsomizer = nil;
    
    [super tearDown];
}

- (void)testSuccessObtainEvents {
    // given
    EventPlainObject *event = [EventPlainObject new];
    
    NSArray *notPonsoObjectsArray = @[@1];
    NSArray *expectedEventsArray = @[event];
    
    OCMStub([self.mockEventService obtainEventsWithPredicate:OCMOCK_ANY]).andReturn(notPonsoObjectsArray);
    OCMStub([self.mockPonsomizer convertObject:notPonsoObjectsArray]).andReturn(expectedEventsArray);
    
    // when
    NSArray *eventsArray = [self.searchFacade eventsForPredicates:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockEventService obtainEventsWithPredicate:OCMOCK_ANY]);
    OCMVerify([self.mockPonsomizer convertObject:notPonsoObjectsArray]);
    XCTAssertEqualObjects(eventsArray, expectedEventsArray);
}

- (void)testSuccessObtainSpeakers {
    // given
    SpeakerPlainObject *speaker = [SpeakerPlainObject new];
    
    NSArray *notPonsoObjectsArray = @[@1];
    NSArray *expectedSpeakersArray = @[speaker];
    
    OCMStub([self.mockSpeakerService obtainSpeakerWithPredicate:OCMOCK_ANY]).andReturn(notPonsoObjectsArray);
    OCMStub([self.mockPonsomizer convertObject:notPonsoObjectsArray]).andReturn(expectedSpeakersArray);
    
    // when
    NSArray *speakersArray = [self.searchFacade speakersForPredicates:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockSpeakerService obtainSpeakerWithPredicate:OCMOCK_ANY]);
    OCMVerify([self.mockPonsomizer convertObject:notPonsoObjectsArray]);
    XCTAssertEqualObjects(speakersArray, expectedSpeakersArray);
}

- (void)testSuccessObtainLectures {
    // given
    LecturePlainObject *lecture = [LecturePlainObject new];
    
    NSArray *notPonsoObjectsArray = @[@1];
    NSArray *expectedLecturesArray = @[lecture];
    
    OCMStub([self.mockLectureService obtainLectureWithPredicate:OCMOCK_ANY]).andReturn(notPonsoObjectsArray);
    OCMStub([self.mockPonsomizer convertObject:notPonsoObjectsArray]).andReturn(expectedLecturesArray);
    
    // when
    NSArray *lecturesArray = [self.searchFacade lecturesForPredicates:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockLectureService obtainLectureWithPredicate:OCMOCK_ANY]);
    OCMVerify([self.mockPonsomizer convertObject:notPonsoObjectsArray]);
    XCTAssertEqualObjects(lecturesArray, expectedLecturesArray);
}

@end
