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
#import "EventPlainObject.h"
#import "PrototypeMapper.h"
#import "EventTypeDeterminator.h"
#import "EventInteractorOutput.h"
#import "EventStoreServiceProtocol.h"
#import "ErrorConstants.h"
#import "ROSPonsomizer.h"
#import "ModelObjectGenerator.h"

typedef void (^ProxyBlock)(NSInvocation *);

@interface EventInteractorTests : XCTestCase

@property (strong, nonatomic) EventInteractor *interactor;
@property (strong, nonatomic) id eventServiceMock;
@property (strong, nonatomic) id ponsomizerMock;
@property (strong, nonatomic) id eventTypeDeterminatorMock;
@property (strong, nonatomic) id presenterMock;
@property (strong, nonatomic) id eventStoreServiceMock;

@end

@implementation EventInteractorTests

- (void)setUp {
    [super setUp];

    self.interactor = [EventInteractor new];
    self.eventServiceMock = OCMProtocolMock(@protocol(EventService));
    self.ponsomizerMock = OCMProtocolMock(@protocol(ROSPonsomizer));
    self.eventTypeDeterminatorMock = OCMClassMock([EventTypeDeterminator class]);
    self.presenterMock = OCMProtocolMock(@protocol(EventInteractorOutput));
    self.eventStoreServiceMock = OCMProtocolMock(@protocol(EventStoreServiceProtocol));
    
    self.interactor.eventService = self.eventServiceMock;
    self.interactor.ponsomizer = self.ponsomizerMock;
    self.interactor.eventTypeDeterminator = self.eventTypeDeterminatorMock;
    self.interactor.output = self.presenterMock;
    self.interactor.eventStoreService = self.eventStoreServiceMock;
}

- (void)tearDown {
    self.interactor = nil;
    [self.eventServiceMock stopMocking];
    self.eventServiceMock = nil;
    
    [self.ponsomizerMock stopMocking];
    self.ponsomizerMock = nil;
    
    [self.eventTypeDeterminatorMock stopMocking];
    self.eventTypeDeterminatorMock = nil;
    
    [self.presenterMock stopMocking];
    self.presenterMock = nil;
    
    [self.eventStoreServiceMock stopMocking];
    self.eventStoreServiceMock = nil;
    
    [super tearDown];
}

- (void)testSuccessObtainEventWithObjectId {
    // given
    EventPlainObject *event = [EventPlainObject new];
    EventPlainObject *obtainedEvent = [EventPlainObject new];
    NSArray *events = @[event];
    
    OCMStub([self.eventServiceMock obtainEventWithPredicate:OCMOCK_ANY]).andReturn(events);
    OCMStub([self.ponsomizerMock convertObject:event]).andReturn(obtainedEvent);

    // when
    EventPlainObject *result = [self.interactor obtainEventWithObjectId:OCMOCK_ANY];
    
    // then
    OCMVerify([self.eventTypeDeterminatorMock determinateTypeForEvent:obtainedEvent]);
    XCTAssertEqualObjects(obtainedEvent, result);
}

- (void)testSuccessObtainPastEventsWithObjectId {
    // given
    NSArray *plainEvents = [ModelObjectGenerator generateEventObjects:5];
    
    OCMStub([self.ponsomizerMock convertObject:OCMOCK_ANY]).andReturn(plainEvents);
    
    // when
    NSArray *result = [self.interactor obtainPastEventsForMetaEvent:OCMOCK_ANY];
    
    // then
    for (id event in plainEvents) {
        OCMVerify([self.eventTypeDeterminatorMock determinateTypeForEvent:event]);
    }
    XCTAssertNotNil(result);
}


- (void)testSuccessSaveEventToCalendar {
    // given
    EventPlainObject *event = [EventPlainObject new];
    
    ProxyBlock proxyBlock = ^(NSInvocation *invocation) {
        void(^completioinBlock)(NSArray *errors);
        
        [invocation getArgument:&completioinBlock atIndex:3];
        
        completioinBlock(nil);
    };
    
    OCMStub([self.eventStoreServiceMock saveEventToCaledar:event withCompletionBlock:OCMOCK_ANY]).andDo(proxyBlock);
    
    // when
    [self.interactor saveEventToCalendar:event];
    
    // then
    OCMVerify([self.presenterMock didSaveEventToCalendarWithError:nil]);
}

- (void)testSuccessSaveEventToCalendarWithError {
    // given
    NSError *error = [NSError errorWithDomain:ErrorDomain code:ErrorEventAlreadyStoredInCalendar userInfo:nil];
    NSArray *errors = @[error];
    
    EventPlainObject *event = [EventPlainObject new];
    
    ProxyBlock proxyBlock = ^(NSInvocation *invocation) {
        void(^completioinBlock)(NSArray *errors);
        
        [invocation getArgument:&completioinBlock atIndex:3];
        
        completioinBlock(errors);
    };
    
    OCMStub([self.eventStoreServiceMock saveEventToCaledar:event withCompletionBlock:OCMOCK_ANY]).andDo(proxyBlock);
    
    // when
    [self.interactor saveEventToCalendar:event];
    
    // then
    OCMVerify([self.presenterMock didSaveEventToCalendarWithError:error]);
}

- (void)testSuccessObtainActivityItemsForEvent {
    // given
    
    // when
    NSArray *obtainedItems = [self.interactor obtainActivityItemsForEvent:OCMOCK_ANY];
    
    // then
    XCTAssertNotNil(obtainedItems);
    // TODO: Complete test after method get implemented
}

@end
