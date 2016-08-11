//
//  EventServiceTests.m
//  Conferences
//
//  Created by Karpushin Artem on 21/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MagicalRecord/MagicalRecord.h>
#import <OCMock/OCMock.h>
#import "XCTestCase+RCFHelpers.h"
#import "TestConstants.h"

#import "EventServiceImplementation.h"
#import "EventListOperationFactory.h"
#import "OperationScheduler.h"
#import "CompoundOperationBase.h"
#import "EventModelObject.h"

@interface EventServiceTests : XCTestCase

@property (strong, nonatomic) EventServiceImplementation *eventService;
@property (nonatomic, strong) EventListOperationFactory *mockEventOperationFactory;
@property (nonatomic, strong) id <OperationScheduler> mockOperationScheduler;
@end

@implementation EventServiceTests

- (void)setUp {
    [super setUp];
    
    [MagicalRecord setDefaultModelFromClass:[self class]];
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    
    self.eventService = [EventServiceImplementation new];
    self.mockEventOperationFactory = OCMClassMock([EventListOperationFactory class]);
    self.mockOperationScheduler = OCMProtocolMock(@protocol(OperationScheduler));
    self.eventService.operationScheduler = self.mockOperationScheduler;
    self.eventService.eventOperationFactory = self.mockEventOperationFactory;
}

- (void)tearDown {
    [MagicalRecord cleanUp];
    
    self.eventService = nil;
    self.mockEventOperationFactory = nil;
    self.mockOperationScheduler = nil;
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

@end
