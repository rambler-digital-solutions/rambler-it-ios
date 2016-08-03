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

#import "EventListServiceImplementation.h"
#import "EventListOperationFactory.h"
#import "OperationScheduler.h"
#import "CompoundOperationBase.h"
#import "XCTestCase+RCFHelpers.h"
#import "TestConstants.h"

@interface EventListServiceTests : XCTestCase

@property (nonatomic, strong) EventListServiceImplementation *service;
@property (nonatomic, strong) id mockOperationFactory;
@property (nonatomic, strong) id mockScheduler;

@end

@implementation EventListServiceTests

- (void)setUp {
    [super setUp];
    
    self.service = [EventListServiceImplementation new];
    
    self.mockOperationFactory = OCMClassMock([EventListOperationFactory class]);
    self.mockScheduler = OCMProtocolMock(@protocol(OperationScheduler));
    
    self.service.eventListOperationFactory = self.mockOperationFactory;
    self.service.operationScheduler = self.mockScheduler;
    
    // Automatically executes the result block of the passed operation
    void(^block)(NSInvocation *invocation) = ^(NSInvocation *invocation) {
        [invocation retainArguments];
        CompoundOperationBase *operation;
        [invocation getArgument:&operation atIndex:2];
        operation.resultBlock(nil, nil);
    };
    OCMStub([self.mockScheduler addOperation:OCMOCK_ANY]).andDo(block);
}

- (void)tearDown {
    self.service = nil;
    
    [self.mockOperationFactory stopMocking];
    self.mockOperationFactory = nil;
    
    self.mockScheduler = nil;
    
    [super tearDown];
}

- (void)testThatServiceUpdatesEventList {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    CompoundOperationBase *mockOperation = [CompoundOperationBase new];
    OCMStub([self.mockOperationFactory getEventsOperationWithQuery:OCMOCK_ANY modelObjectId:OCMOCK_ANY]).andReturn(mockOperation);
    
    id mockQuery = [NSObject new];
    
    // when
    [self.service updateEventListWithQuery:mockQuery completionBlock:^(NSError *error) {
        [expectation fulfill];
    }];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        OCMVerify([self.mockOperationFactory getEventsOperationWithQuery:mockQuery modelObjectId:OCMOCK_ANY]);
        OCMVerify([self.mockScheduler addOperation:mockOperation]);
    }];
}

@end
