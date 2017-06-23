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

#import "TestConstants.h"
#import "XCTestCase+RCFHelpers.h"
#import "TestChainableOperation.h"
#import "TestErrorChainableOperation.h"
#import "TestCancellableOperation.h"
#import "TestChainableOperationWithValidationBlock.h"
#import "CompoundOperationBase.h"
#import "OperationBuffer.h"

@interface CompoundOperationBaseTests : XCTestCase

@property (nonatomic, strong) CompoundOperationBase *compoundOperation;
@property (nonatomic, strong) OperationBuffer *startBuffer;
@property (nonatomic, strong) OperationBuffer *endBuffer;

@end

@implementation CompoundOperationBaseTests

- (void)setUp {
    [super setUp];
    
    self.compoundOperation = [CompoundOperationBase new];
    self.startBuffer = [OperationBuffer buffer];
    self.endBuffer = [OperationBuffer buffer];
    
    self.compoundOperation.queueInput = self.startBuffer;
    self.compoundOperation.queueOutput = self.endBuffer;
}

- (void)tearDown {
    self.compoundOperation = nil;
    
    [super tearDown];
}

- (void)testThatOperationHandlesInputAndOutputCorrectData {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];

    TestChainableOperation *operation = [TestChainableOperation new];
    operation.delegate = self.compoundOperation;
    
    [self.startBuffer setOperationQueueInputData:@"text"];
    
    operation.input = self.startBuffer;
    operation.output = self.endBuffer;
    
    __block NSString *resultString;
    self.compoundOperation.resultBlock = ^(id data, NSError *error){
        resultString = [self.compoundOperation.queueOutput obtainOperationQueueOutputData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [expectation fulfill];
        });
    };
    
    // when
    [self.compoundOperation addOperation:operation];
    [self.compoundOperation start];
    
    // then
    
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        XCTAssertEqualObjects(resultString, @"text-processed");
        XCTAssertTrue(self.compoundOperation.isFinished);
    }];
}

- (void)testThatOperationHandlesInnerOperationWithError {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    TestErrorChainableOperation *operation = [TestErrorChainableOperation new];
    operation.delegate = self.compoundOperation;
    
    __block NSError *resultError;
    self.compoundOperation.resultBlock = ^(id data, NSError *error){
        resultError = error;
        dispatch_async(dispatch_get_main_queue(), ^{
            [expectation fulfill];
        });
    };
    
    // when
    [self.compoundOperation addOperation:operation];
    [self.compoundOperation start];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        XCTAssertNotNil(resultError);
        XCTAssertTrue(self.compoundOperation.isFinished);
    }];
}

- (void)testThatOperationCancelsInnerOperations {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    TestCancellableOperation *operation = [TestCancellableOperation new];
    operation.delegate = self.compoundOperation;
    operation.output = self.endBuffer;
    __block BOOL wasCancelled = NO;
    
    self.compoundOperation.resultBlock = ^(id data, NSError *error){
        if (!data) {
            wasCancelled = YES;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [expectation fulfill];
        });
    };
    
    // when
    [self.compoundOperation addOperation:operation];
    [self.compoundOperation start];
    [self.compoundOperation cancel];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        XCTAssertTrue(wasCancelled);
        XCTAssertTrue(self.compoundOperation.isCancelled);
        XCTAssertTrue(self.compoundOperation.isFinished);
    }];
}

- (void)testThatOperationCompletesSuccessfullyWithDataTypeValidation {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    TestChainableOperationWithValidationBlock *operation = [TestChainableOperationWithValidationBlock new];
    operation.delegate = self.compoundOperation;
    operation.input = self.startBuffer;
    operation.output = self.endBuffer;
    
    NSDictionary *inputData = @{};
    
    [self.startBuffer setOperationQueueInputData:inputData];
    
    self.compoundOperation.resultBlock = ^(id data, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            [expectation fulfill];
        });
    };
    
    // when
    [self.compoundOperation addOperation:operation];
    [self.compoundOperation start];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:nil];
}

- (void)testThatOperationThrowsExceptionWithDataTypeValidation {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    TestChainableOperationWithValidationBlock *operation = [TestChainableOperationWithValidationBlock new];
    operation.delegate = self.compoundOperation;
    operation.input = self.startBuffer;
    operation.output = self.endBuffer;
    
    NSArray *inputData = @[];
    
    [self.startBuffer setOperationQueueInputData:inputData];
    
    __block NSException *resultException;
    self.compoundOperation.resultBlock = ^(id data, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            resultException = [self.endBuffer obtainOperationQueueOutputData];
            [expectation fulfill];
        });
    };
    
    // when
    [self.compoundOperation addOperation:operation];
    [self.compoundOperation start];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        XCTAssertNotNil(resultException);
        XCTAssertEqualObjects(resultException.name, NSInternalInconsistencyException);
    }];
}

@end
