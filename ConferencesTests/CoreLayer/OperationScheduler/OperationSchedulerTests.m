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

#import "XCTestCase+RCFHelpers.h"
#import "TestConstants.h"

#import "OperationSchedulerImplementation.h"

@interface OperationSchedulerTests : XCTestCase

@property (strong, nonatomic) OperationSchedulerImplementation *scheduler;

@end

@implementation OperationSchedulerTests

- (void)setUp {
    [super setUp];
    
    self.scheduler = [[OperationSchedulerImplementation alloc] init];
}

- (void)tearDown {
    self.scheduler = nil;
    
    [super tearDown];
}

- (void)testThatSchedulerProcessSingleOperation {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        [expectation fulfill];
    }];
    
    // when
    [self.scheduler addOperation:operation];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:nil];
}

- (void)testThatSchedulerProcessMultipleOperations {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    NSUInteger const kOperationsNumber = 10;
    __block NSUInteger operationsCallCounter = 0;
    
    NSBlockOperation *barrierOperation = [NSBlockOperation blockOperationWithBlock:^{
        [expectation fulfill];
    }];
    
    NSMutableArray *mutableOperations = [NSMutableArray array];
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_SERIAL, 0);
    for (NSUInteger i = 0; i < kOperationsNumber; i++) {
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            dispatch_async(queue, ^{
                operationsCallCounter += 1;
            });
        }];
        
        [barrierOperation addDependency:operation];
        [mutableOperations addObject:operation];
    }
    
    // when
    [self.scheduler addOperation:barrierOperation];
    for (NSOperation *operation in mutableOperations) {
        [self.scheduler addOperation:operation];
    }
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError * _Nullable error) {
        XCTAssertEqual(operationsCallCounter, kOperationsNumber);
    }];
    
}

@end
