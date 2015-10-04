//
//  OperationChainerTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "OperationChainer.h"
#import "CompoundOperationBase.h"
#import "OperationBuffer.h"
#import "ChainableOperation.h"

#import "TestChainableOperation.h"

@interface OperationChainerTests : XCTestCase

@property (strong, nonatomic) OperationChainer *chainer;

@end

@implementation OperationChainerTests

- (void)setUp {
    [super setUp];
    self.chainer = [[OperationChainer alloc] init];
}

- (void)tearDown {
    self.chainer = nil;
    [super tearDown];
}

- (void)testThatChainerChainsSuboperations {
    // given
    TestChainableOperation *firstOperation = [TestChainableOperation new];
    TestChainableOperation *secondOperation = [TestChainableOperation new];
    
    OperationBuffer *buffer = [OperationBuffer buffer];
    
    // when
    [self.chainer chainParentOperation:firstOperation
                    withChildOperation:secondOperation
                            withBuffer:buffer];
    
    // then
    XCTAssertEqual(firstOperation.dependencies.count, 0);
    XCTAssertEqual(secondOperation.dependencies.count, 1);
    XCTAssertEqualObjects([secondOperation.dependencies firstObject], firstOperation);
    XCTAssertEqualObjects(firstOperation.output, buffer);
    XCTAssertEqualObjects(secondOperation.input, buffer);
}

- (void)testThatChainerChainsCompoundOperationWIthItsQueue {
    // given
    CompoundOperationBase *compoundOperation = [CompoundOperationBase new];
    TestChainableOperation *firstOperation = [TestChainableOperation new];
    TestChainableOperation *secondOperation = [TestChainableOperation new];
    
    NSArray *chainableOperations = @[firstOperation, secondOperation];
    
    // when
    [self.chainer chainCompoundOperation:compoundOperation
            withChainableOperationsQueue:chainableOperations];
    
    // then
    XCTAssertEqualObjects(firstOperation.input, compoundOperation.queueInput);
    XCTAssertEqualObjects(secondOperation.output, compoundOperation.queueOutput);
}

@end
