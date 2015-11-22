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
#import "EventOperationFactory.h"
#import "OperationScheduler.h"
#import "CompoundOperationBase.h"
#import "Event.h"

@interface EventServiceTests : XCTestCase

@property (strong, nonatomic) EventServiceImplementation *eventService;

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
    
    EventOperationFactory *mockEventOperationFactory = OCMClassMock([EventOperationFactory class]);
    OCMStub([mockEventOperationFactory getEventsOperationWithQuery:nil]).andReturn(compoundOperation);
    id <OperationScheduler> mockOperationScheduler = OCMProtocolMock(@protocol(OperationScheduler));
    
    self.eventService.eventOperationFactory = mockEventOperationFactory;
    self.eventService.operationScheduler = mockOperationScheduler;
    
    // when
    [self.eventService updateEventWithPredicate:OCMOCK_ANY completionBlock:nil];
    
    // then
    OCMVerify([mockOperationScheduler addOperation:compoundOperation]);
}

- (void)testSuccessObtainEventWithPredicate {
    // given
    NSString *eventObjectId = @"8dk2da";
    
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext MR_rootSavingContext];
    [managedObjectContext MR_saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        Event *event = [Event MR_createEntity];
        event.objectId = eventObjectId;
    }];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId = %@", eventObjectId];
    
    // when
    NSArray *events = [self.eventService obtainEventWithPredicate:predicate];
    Event *event = [events firstObject];
    
    // then
    XCTAssertNotNil(event);
}

@end
