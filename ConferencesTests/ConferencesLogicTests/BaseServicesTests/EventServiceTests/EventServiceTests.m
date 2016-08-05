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

#import "EventServiceImplementation.h"
#import "EventListOperationFactory.h"
#import "OperationScheduler.h"
#import "CompoundOperationBase.h"
#import "EventModelObject.h"

@interface EventServiceTests : XCTestCase

@property (nonatomic, strong) EventServiceImplementation *eventService;

@end

@implementation EventServiceTests

- (void)setUp {
    [super setUp];
    
    [MagicalRecord setDefaultModelFromClass:[self class]];
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    
    self.eventService = [EventServiceImplementation new];
}

- (void)tearDown {
    [MagicalRecord cleanUp];
    
    self.eventService = nil;

    [super tearDown];
}

- (void)testSuccessUpdateEventWithPredicate {
    // given
    CompoundOperationBase *compoundOperation = [CompoundOperationBase new];
    
    id mockEventOperationFactory = OCMClassMock([EventListOperationFactory class]);
    OCMStub([mockEventOperationFactory getEventsOperationWithQuery:nil]).andReturn(compoundOperation);
    id <OperationScheduler> mockOperationScheduler = OCMProtocolMock(@protocol(OperationScheduler));
    
    self.eventService.eventOperationFactory = mockEventOperationFactory;
    self.eventService.operationScheduler = mockOperationScheduler;
    
    // when
    [self.eventService updateEventWithPredicate:OCMOCK_ANY completionBlock:nil];
    
    // then
    OCMVerify([mockOperationScheduler addOperation:compoundOperation]);
    [mockEventOperationFactory stopMocking];
}

@end
