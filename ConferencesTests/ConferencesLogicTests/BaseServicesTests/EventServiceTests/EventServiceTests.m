// Copyright (c) 2016 RAMBLER&Co
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
