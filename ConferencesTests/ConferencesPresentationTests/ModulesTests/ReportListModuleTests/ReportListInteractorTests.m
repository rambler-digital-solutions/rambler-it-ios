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

#import "ReportListInteractor.h"
#import "ReportListInteractorOutput.h"

#import "EventService.h"
#import "EventTypeDeterminator.h"
#import "EventPlainObject.h"
#import "EventModelObject.h"
#import "ROSPonsomizer.h"

#import "XCTestCase+RCFHelpers.h"
#import "TestConstants.h"
typedef void (^ProxyBlock)(NSInvocation *);

@interface ReportListInteractorTests : XCTestCase

@property (strong, nonatomic) ReportListInteractor *interactor;
@property (strong, nonatomic) EventTypeDeterminator *mockEventTypeDeterminator;
@property (strong, nonatomic) id <ReportListInteractorOutput> mockOutput;
@property (strong, nonatomic) id <EventService> mockEventService;
@property (strong, nonatomic) id <ROSPonsomizer> mockPonsomizer;

@end

@implementation ReportListInteractorTests

- (void)setUp {
    [super setUp];
    
    self.interactor = [ReportListInteractor new];
    self.mockOutput = OCMProtocolMock(@protocol(ReportListInteractorOutput));
    self.mockEventService = OCMProtocolMock(@protocol(EventService));
    self.mockEventTypeDeterminator = OCMClassMock([EventTypeDeterminator class]);
    self.mockPonsomizer = OCMProtocolMock(@protocol(ROSPonsomizer));
    
    self.interactor.output = self.mockOutput;
    self.interactor.eventService = self.mockEventService;
    self.interactor.eventTypeDeterminator = self.mockEventTypeDeterminator;
    self.interactor.ponsomizer = self.mockPonsomizer;
}

- (void)tearDown {
    self.interactor = nil;
    self.mockOutput = nil;
    self.mockEventService = nil;
    self.mockEventTypeDeterminator = nil;
    self.mockPonsomizer = nil;

    [super tearDown];
}

- (void)testSuccessUpdateEventList {
    // given
    NSObject *event = [NSObject new];
    NSArray *data = @[event];
    NSArray *eventsPonso = @[@1];
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    ProxyBlock proxyBlock = ^(NSInvocation *invocation){
        void(^completionBlock)(id data, NSError *error);
        
        [invocation getArgument:&completionBlock atIndex:2];
        [expectation fulfill];
        completionBlock(data, nil);
    };
    
    OCMStub([self.mockEventService updateEventListWithCompletionBlock:OCMOCK_ANY]).andDo(proxyBlock);
    // when
    [self.interactor updateEventList];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout
                                 handler:^(NSError * _Nullable error) {
                                     OCMVerify([self.mockOutput didUpdatedEvents]);
                                 }];
}

- (void)testSuccessObtainEventList {
    // given
    NSObject *event = [NSObject new];
    NSArray *events = @[event];
    
    OCMStub([self.mockEventService obtainEventsWithPredicate:nil]).andReturn(events);
    OCMStub([self.mockPonsomizer convertObject:OCMOCK_ANY]).andReturn(events);
    // when
    id result = [self.interactor obtainEventList];
    
    // then
    XCTAssertNotNil(result);
    OCMVerify([self.mockEventTypeDeterminator determinateTypeForEvent:OCMOCK_ANY]);
    OCMVerify([self.mockPonsomizer convertObject:events]);
    OCMVerify([self.mockEventService obtainEventsWithPredicate:OCMOCK_ANY]);
}

- (void)testSuccessObtainEventListWithPredicate {
    // given
    EventPlainObject *event = [EventPlainObject new];
    event.name = @"Test PrediCate";
    
    NSArray *events = @[event];
    NSArray *eventsPonso = @[@1];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@", @"Test"];
    OCMStub([self.mockEventTypeDeterminator determinateTypeForEvent:OCMOCK_ANY]).andReturn(PastEvent);
    OCMStub([self.mockEventService obtainEventsWithPredicate:predicate]).andReturn(events);
    OCMStub([self.mockPonsomizer convertObject:events]).andReturn(eventsPonso);
    
    // when
    id result = [self.interactor obtainEventListWithPredicate:predicate];
    
    // then
    XCTAssertNotNil(result);
    OCMVerify([self.mockEventTypeDeterminator determinateTypeForEvent:OCMOCK_ANY]);
    OCMVerify([self.mockPonsomizer convertObject:events]);
    OCMVerify([self.mockEventService obtainEventsWithPredicate:OCMOCK_ANY]);
}
@end
