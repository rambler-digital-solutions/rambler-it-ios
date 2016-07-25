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

#import "EventTypeDeterminator.h"
#import "EventInteractorOutput.h"
#import "EventStoreServiceProtocol.h"
#import "ErrorConstants.h"

typedef void (^ProxyBlock)(NSInvocation *);

@interface EventInteractorTests : XCTestCase

@property (strong, nonatomic) EventInteractor *interactor;
@property (strong, nonatomic) id <EventService> eventServiceMock;
@property (strong, nonatomic) id <> prototypeMapperMock;
@property (strong, nonatomic) EventTypeDeterminator *eventTypeDeterminatorMock;
@property (strong, nonatomic) id <EventInteractorOutput> presenterMock;
@property (strong, nonatomic) id eventStoreServiceMock;

@end

@implementation EventInteractorTests

- (void)setUp {
    [super setUp];

    self.interactor = [EventInteractor new];
    self.eventServiceMock = OCMProtocolMock(@protocol(EventService));
    self.prototypeMapperMock = OCMProtocolMock(@protocol(PrototypeMapper));
    self.eventTypeDeterminatorMock = OCMClassMock([EventTypeDeterminator class]);
    self.presenterMock = OCMProtocolMock(@protocol(EventInteractorOutput));
    self.eventStoreServiceMock = OCMProtocolMock(@protocol(EventStoreServiceProtocol));
    
    self.interactor.eventService = self.eventServiceMock;
    self.interactor.eventPrototypeMapper = self.prototypeMapperMock;
    self.interactor.eventTypeDeterminator = self.eventTypeDeterminatorMock;
    self.interactor.output = self.presenterMock;
    self.interactor.eventStoreService = self.eventStoreServiceMock;
}

- (void)tearDown {
    self.interactor = nil;
    [(id)self.eventServiceMock stopMocking];
    self.eventServiceMock = nil;
    [(id)self.prototypeMapperMock stopMocking];
    self.prototypeMapperMock = nil;
    [(id)self.eventTypeDeterminatorMock stopMocking];
    self.eventTypeDeterminatorMock = nil;
    [(id)self.presenterMock stopMocking];
    self.presenterMock = nil;
    [self.eventStoreServiceMock stopMocking];
    self.eventStoreServiceMock = nil;
    
    [super tearDown];
}

- (void)testSuccessObtainEventWithObjectId {
    // given
    NSObject *event = [EventPlainObject new];
    NSArray *events = @[event];
    
    OCMStub([self.eventServiceMock obtainEventWithPredicate:OCMOCK_ANY]).andReturn(events);
    
    // when
    EventPlainObject *obtainedEvent = [self.interactor obtainEventWithObjectId:OCMOCK_ANY];
    
    // then
    OCMVerify([self.prototypeMapperMock fillObject:OCMOCK_ANY withObject:event]);
    OCMVerify([self.eventTypeDeterminatorMock determinateTypeForEvent:OCMOCK_ANY]);
    XCTAssertNotNil(obtainedEvent);
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
