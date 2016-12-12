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
#import <Messages/Messages.h>

#import "MessagesInteractor.h"
#import "EventService.h"
#import "ROSPonsomizer.h"
#import "EventListInteractorOutput.h"
#import "EventPlainObject.h"
#import "ObjectTransformer.h"
#import "EventListProcessor.h"
#import "MockObjectsFactory.h"

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
    NSString *identifier = [NSString stringWithFormat:[MockObjectsFactory eventModelObjectScheme], [MockObjectsFactory randomObjectIdentifier]];
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
    NSString *identifier = [NSString stringWithFormat:[MockObjectsFactory eventModelObjectScheme], [MockObjectsFactory randomObjectIdentifier]];
    OCMStub([self.mockTransformer isCorrectIdentifier:identifier]).andReturn(YES);

    // when
    BOOL isCorrectIdentifier = [self.interactor isCorrectIdentifier:identifier];

    // then
    XCTAssertTrue(isCorrectIdentifier);
}

@end
