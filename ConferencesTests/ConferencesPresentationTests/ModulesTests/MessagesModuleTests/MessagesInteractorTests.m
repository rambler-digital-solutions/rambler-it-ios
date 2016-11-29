//
//  MessagesInteractorTests.m
//  Conferences
//
//  Created by Trishina Ekaterina on 16/11/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <Messages/Messages.h>

#import "MessagesInteractor.h"
#import "EventService.h"
#import "ROSPonsomizer.h"
#import "EventListInteractorOutput.h"
#import "EventPlainObject.h"
#import "ObjectTransformer.h"
#import "EventListProcessor.h"

@interface MessagesInteractorTests : XCTestCase

@property (nonatomic, strong) MessagesInteractor *interactor;
@property (nonatomic, strong) id <EventService> mockEventService;
@property (nonatomic, strong) id <ROSPonsomizer> mockPonsomizer;
@property (nonatomic, strong) id <EventListInteractorOutput> mockOutput;
@property (nonatomic, strong) id <ObjectTransformer> mockTransformer;
@property (nonatomic, strong) EventListProcessor *mockListProcessor;

@end

@implementation MessagesInteractorTests

- (void)setUp {
    [super setUp];

    self.interactor = [MessagesInteractor new];
    self.mockEventService = OCMProtocolMock(@protocol(EventService));
    self.mockPonsomizer = OCMProtocolMock(@protocol(ROSPonsomizer));
    self.mockTransformer = OCMProtocolMock(@protocol(ObjectTransformer));
    self.mockListProcessor = OCMClassMock([EventListProcessor class]);

    self.interactor.eventService = self.mockEventService;
    self.interactor.output = self.mockOutput;
    self.interactor.ponsomizer = self.mockPonsomizer;
    self.interactor.transformer = self.mockTransformer;
    self.interactor.eventListProcessor = self.mockListProcessor;
}

- (void)tearDown {
    self.interactor = nil;
    self.mockEventService = nil;
    self.mockOutput = nil;
    self.mockPonsomizer = nil;
    self.mockTransformer = nil;
    self.mockListProcessor = nil;

    [super tearDown];
}

- (void)testSuccessObtainEventList {
    // given
    NSObject *event = [NSObject new];
    NSArray *eventsManagedObjects = @[event];
    NSArray *eventsPlainObjects = @[@1];

    OCMStub([self.mockEventService obtainEventsWithPredicate:nil]).andReturn(eventsManagedObjects);
    OCMStub([self.mockPonsomizer convertObject:eventsManagedObjects]).andReturn(eventsPlainObjects);
    OCMStub([self.mockListProcessor sortEventsByDate:eventsPlainObjects]).andReturn(eventsPlainObjects);

    // when
    id result = [self.interactor obtainEventList];

    // then
    XCTAssertEqualObjects(result, eventsPlainObjects);
}

- (void)testSuccessCreateMessage {
    // given
    EventPlainObject *eventObject = [[EventPlainObject alloc] init];
    NSString *identifier = @"EventModelObject_42";
    NSURL *givenURL = [NSURL URLWithString:identifier];
    OCMStub([self.mockTransformer identifierForObject:eventObject]).andReturn(identifier);

    // when
    MSMessage *message = [self.interactor createMessageFromEvent:eventObject];

    // then
    XCTAssertNotNil(message);
    XCTAssertEqualObjects(givenURL, message.URL);
}

- (void)testCorrectIdentifier {
    // given
    NSString *identifier = @"EventModelObject_42";
    OCMStub([self.mockTransformer isCorrectIdentifier:identifier]).andReturn(YES);

    // when
    BOOL isCorrectIdentifier = [self.interactor isCorrectIdentifier:identifier];

    // then
    XCTAssertTrue(isCorrectIdentifier);
}

@end
