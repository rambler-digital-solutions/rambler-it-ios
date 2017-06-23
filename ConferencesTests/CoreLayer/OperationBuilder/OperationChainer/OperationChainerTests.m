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

#import "OperationChainer.h"
#import "CompoundOperationBase.h"
#import "OperationBuffer.h"
#import "ChainableOperation.h"

#import "TestChainableOperation.h"

@interface OperationChainerTests : XCTestCase

@property (nonatomic, strong) OperationChainer *chainer;

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
