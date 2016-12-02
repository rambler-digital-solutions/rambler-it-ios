//
//  SearchFacadeTests.m
//  Conferences
//
//  Created by s.sarkisyan on 02.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

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
    self.mockEventService = OCMProtocolMock(@protocol(EventService));
    self.mockSpeakerService = OCMProtocolMock(@protocol(SpeakerService));
    self.mockLectureService = OCMProtocolMock(@protocol(LectureService));
    self.mockPonsomizer = OCMProtocolMock(@protocol(ROSPonsomizer));
    
    self.searchFacade.eventService = self.mockEventService;
    self.searchFacade.speakerService = self.mockSpeakerService;
    self.searchFacade.lectureService = self.mockLectureService;
    self.searchFacade.ponsomizer = self.mockPonsomizer;
}

- (void)tearDown {
    
    self.searchFacade = nil;
    self.mockEventService = nil;
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
    XCTAssertEqual(eventsArray, expectedEventsArray);
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
    XCTAssertEqual(speakersArray, expectedSpeakersArray);
}

- (void)testSuccessObtainLectures {
    // given
    LecturePlainObject *lecture = [LecturePlainObject new];
    
    NSArray *notPonsoObjectsArray = @[@1];
    NSArray *expectedLecturesArray = @[lecture];
    
    OCMStub([self.mockSpeakerService obtainSpeakerWithPredicate:OCMOCK_ANY]).andReturn(notPonsoObjectsArray);
    OCMStub([self.mockPonsomizer convertObject:notPonsoObjectsArray]).andReturn(expectedLecturesArray);
    
    // when
    NSArray *lecturesArray = [self.searchFacade speakersForPredicates:OCMOCK_ANY];
    
    // then
    XCTAssertEqual(lecturesArray, expectedLecturesArray);
}

@end
