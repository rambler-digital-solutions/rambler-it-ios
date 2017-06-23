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
#import <MagicalRecord/MagicalRecord.h>
#import <OCMock/OCMock.h>

#import "XCTestCase+RCFHelpers.h"
#import "TestConstants.h"

#import "EventServiceImplementation.h"
#import "EventOperationFactory.h"
#import "OperationScheduler.h"
#import "CompoundOperationBase.h"
#import "EventModelObject.h"

@interface EventServiceTests : XCTestCase

@property (nonatomic, strong) EventServiceImplementation *eventService;
@property (nonatomic, strong) EventOperationFactory *mockEventOperationFactory;
@property (nonatomic, strong) id <OperationScheduler> mockOperationScheduler;
@end

@implementation EventServiceTests

- (void)setUp {
    [super setUp];
    
    [self setupCoreDataStackForTests];
    
    self.eventService = [EventServiceImplementation new];
    self.mockEventOperationFactory = OCMClassMock([EventOperationFactory class]);
    self.mockOperationScheduler = OCMProtocolMock(@protocol(OperationScheduler));
    self.eventService.operationScheduler = self.mockOperationScheduler;
    self.eventService.eventOperationFactory = self.mockEventOperationFactory;
}

- (void)tearDown {
    self.eventService = nil;
    self.mockEventOperationFactory = nil;
    self.mockOperationScheduler = nil;
    
    [self tearDownCoreDataStack];
    [super tearDown];
}

- (void)testSuccessUpdateEventWithPredicate {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    CompoundOperationBase *compoundOperation = [CompoundOperationBase new];
    
    ProxyBlock proxyBlock = ^(NSInvocation *invocation){
        [expectation fulfill];
    };
    
    OCMStub([self.mockEventOperationFactory getEventsOperationWithQuery:OCMOCK_ANY modelObjectId:OCMOCK_ANY]).andReturn(compoundOperation);
    OCMStub([self.mockOperationScheduler addOperation:OCMOCK_ANY]).andDo(proxyBlock);
    
    // when
    [self.eventService updateEventListWithCompletionBlock:nil];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout
                                 handler:^(NSError * _Nullable error) {
        OCMVerify([self.mockOperationScheduler addOperation:OCMOCK_ANY]);
    }];
}

- (void)testThatServiceTracksEventVisit {
    // given
    NSString *const kTestEventId = @"1234";
    [self generateEventForTestPurposesWithId:kTestEventId];
    
    // when
    [self.eventService trackEventVisitForEventId:kTestEventId];
    
    // then
    EventModelObject *event = [self obtainEventWithId:kTestEventId];
    XCTAssertNotNil(event.lastVisitDate);
}

#pragma mark - Helper methods

- (void)generateEventForTestPurposesWithId:(NSString *)eventId {
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    [rootSavingContext performBlockAndWait:^{
        EventModelObject *event = [EventModelObject MR_createEntityInContext:rootSavingContext];
        event.eventId = eventId;
        [rootSavingContext MR_saveToPersistentStoreAndWait];
    }];
}

- (EventModelObject *)obtainEventWithId:(NSString *)eventId {
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    EventModelObject *event = [EventModelObject MR_findFirstByAttribute:EventModelObjectAttributes.eventId
                                                              withValue:eventId
                                                              inContext:defaultContext];
    return event;
}

@end
