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
#import <MapKit/MapKit.h>

#import "EventInteractor.h"
#import "EventService.h"
#import "EventPlainObject.h"

#import "EventTypeDeterminator.h"
#import "EventInteractorOutput.h"
#import "EventStoreServiceProtocol.h"
#import "ErrorConstants.h"
#import "ROSPonsomizer.h"
#import "EventPlainObject.h"
#import "ShareUrlBuilder.h"

typedef void (^ProxyBlock)(NSInvocation *);

@interface EventInteractorTests : XCTestCase

@property (nonatomic, strong) EventInteractor *interactor;
@property (nonatomic, strong) id <EventService> eventServiceMock;
@property (nonatomic, strong) EventTypeDeterminator *eventTypeDeterminatorMock;
@property (nonatomic, strong) id <EventInteractorOutput> presenterMock;
@property (nonatomic, strong) id eventStoreServiceMock;
@property (nonatomic, strong) id <ROSPonsomizer>mockPonsomizer;
@property (nonatomic, strong) id mockUrlBuilder;
@end

@implementation EventInteractorTests

- (void)setUp {
    [super setUp];

    self.interactor = [EventInteractor new];
    self.eventServiceMock = OCMProtocolMock(@protocol(EventService));
    self.eventTypeDeterminatorMock = OCMClassMock([EventTypeDeterminator class]);
    self.presenterMock = OCMProtocolMock(@protocol(EventInteractorOutput));
    self.eventStoreServiceMock = OCMProtocolMock(@protocol(EventStoreServiceProtocol));
    self.mockPonsomizer = OCMProtocolMock(@protocol(ROSPonsomizer));
    self.mockUrlBuilder = OCMProtocolMock(@protocol(ShareUrlBuilder));
    
    self.interactor.eventService = self.eventServiceMock;
    self.interactor.eventTypeDeterminator = self.eventTypeDeterminatorMock;
    self.interactor.output = self.presenterMock;
    self.interactor.eventStoreService = self.eventStoreServiceMock;
    self.interactor.ponsomizer = self.mockPonsomizer;
    self.interactor.shareUrlBuilder = self.mockUrlBuilder;
}

- (void)tearDown {
    self.interactor = nil;
    [(id)self.eventServiceMock stopMocking];
    self.eventServiceMock = nil;
    [(id)self.eventTypeDeterminatorMock stopMocking];
    self.eventTypeDeterminatorMock = nil;
    [(id)self.presenterMock stopMocking];
    self.presenterMock = nil;
    [self.eventStoreServiceMock stopMocking];
    self.eventStoreServiceMock = nil;
    self.mockPonsomizer = nil;
    self.mockUrlBuilder = nil;
    
    [super tearDown];
}

- (void)testSuccessObtainEventWithObjectId {
    // given
    NSObject *event = [EventPlainObject new];
    NSArray *events = @[event];
    
    OCMStub([self.eventServiceMock obtainEventsWithPredicate:OCMOCK_ANY]).andReturn(events);
    OCMStub([self.mockPonsomizer convertObject:OCMOCK_ANY]).andReturn(event);
    // when
    EventPlainObject *obtainedEvent = [self.interactor obtainEventWithObjectId:OCMOCK_ANY];
    
    // then
    OCMVerify([self.eventTypeDeterminatorMock determinateTypeForEvent:OCMOCK_ANY]);
    OCMVerify([self.mockPonsomizer convertObject:OCMOCK_ANY]);
    OCMVerify([self.eventServiceMock obtainEventsWithPredicate:OCMOCK_ANY]);
    XCTAssertEqual(obtainedEvent, event);
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
    NSURL *testUrl = [NSURL URLWithString:@"rambler.ru"];
    OCMStub([self.mockUrlBuilder buildShareUrlWithItemId:OCMOCK_ANY]).andReturn(testUrl);
    EventPlainObject *event = [EventPlainObject new];
    
    // when
    NSArray *obtainedItems = [self.interactor obtainActivityItemsForEvent:event];
    
    // then
    XCTAssertNotNil(obtainedItems);
    XCTAssertEqualObjects([obtainedItems firstObject], testUrl);
}

- (void)testThatInteractorTracksEventVisit {
    // given
    NSString *const kTestEventId = @"1234";
    EventPlainObject *event = [EventPlainObject new];
    event.eventId = kTestEventId;
    
    // when
    [self.interactor trackEventVisitForEvent:event];
    
    // then
    OCMVerify([self.eventServiceMock trackEventVisitForEventId:kTestEventId]);
}

- (void)testThatInteractorRegistersUserActivity {
    // given
    EventPlainObject *event = [EventPlainObject new];
    event.name = [[NSUUID UUID] UUIDString];
    
    // when
    NSUserActivity *result = [self.interactor registerUserActivityForEvent:event];
    
    // then
    XCTAssertNotNil(result);
    if (@available(iOS 10, *)) {
        XCTAssertNotNil(result.mapItem);
    }
}

- (void)testThatInteractorUnregistersUserActivity {
    // given
    id mockActivity = OCMClassMock([NSUserActivity class]);
    
    // when
    [self.interactor unregisterUserActivity:mockActivity];
    
    // then
    OCMVerify([mockActivity resignCurrent]);
    [mockActivity stopMocking];
}

@end
