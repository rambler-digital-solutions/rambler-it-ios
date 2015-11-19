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

#import "EventInteractor.h"
#import "EventService.h"
#import "PlainEvent.h"
#import "PrototypeMapper.h"
#import "EventTypeDeterminator.h"

@interface EventInteractorTests : XCTestCase

@property (strong, nonatomic) EventInteractor *interactor;
@property (strong, nonatomic) id <EventService> mockEventService;
@property (strong, nonatomic) id <PrototypeMapper> mockPrototypeMapper;
@property (strong, nonatomic) EventTypeDeterminator *mockEventTypeDeterminator;

@end

@implementation EventInteractorTests

- (void)setUp {
    [super setUp];

    self.interactor = [EventInteractor new];
    self.mockEventService = OCMProtocolMock(@protocol(EventService));
    self.mockPrototypeMapper = OCMProtocolMock(@protocol(PrototypeMapper));
    self.mockEventTypeDeterminator = OCMClassMock([EventTypeDeterminator class]);
    
    self.interactor.eventService = self.mockEventService;
    self.interactor.eventPrototypeMapper = self.mockPrototypeMapper;
    self.interactor.eventTypeDeterminator = self.mockEventTypeDeterminator;
}

- (void)tearDown {
    self.interactor = nil;
    self.mockEventService = nil;
    self.mockPrototypeMapper = nil;
    self.mockEventTypeDeterminator = nil;
    
    [super tearDown];
}

- (void)testSuccessObtainEventByObjectId {
    // given
    NSObject *event = [NSObject new];
    NSArray *events = @[event];
    
    OCMStub([self.mockEventService obtainEventWithPredicate:OCMOCK_ANY]).andReturn(events);
    
    // when
    [self.interactor obtainEventByObjectId:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockPrototypeMapper fillObject:OCMOCK_ANY withObject:event]);
    OCMVerify([self.mockEventTypeDeterminator determinateTypeForEvent:OCMOCK_ANY]);
}

@end
