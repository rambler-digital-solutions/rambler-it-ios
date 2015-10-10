//
//  OperationSchedulerTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 06/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

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
