//
//  ResponseConverterOperationTests.m
//  Conferences
//
//  Created by k.zinovyev on 18.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ChainableOperationTestsBase.h"
#import "ResponseConverterOperation.h"
#import "ResponseConverter.h"
#import <OCMock/OCMock.h>
#import "OperationBuffer.h"

@interface ResponseConverterOperationTests : ChainableOperationTestsBase

@property (nonatomic, strong) ResponseConverterOperation *operation;
@property (nonatomic, strong) id<ResponseConverter> mockResponseConverter;

@end

@implementation ResponseConverterOperationTests

- (void)setUp {
    [super setUp];
    
    self.mockResponseConverter = OCMProtocolMock(@protocol(ResponseConverter));
    self.operation = [ResponseConverterOperation operationWithResponseConverter:self.mockResponseConverter];
}

- (void)tearDown {
    self.operation = nil;
    self.mockResponseConverter = nil;
    
    [super tearDown];
}

- (void)testThatOperationCallsConfiguratorOnExecute {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    NSDictionary *inputData = [NSDictionary new];
    [self setInputData:inputData
          forOperation:self.operation];
    
    [self.operation setCompletionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [expectation fulfill];
        });
    }];
    
    // when
    [self.operation start];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        OCMVerify([self.mockResponseConverter convertFromResponse:inputData]);
    }];
    
}

- (void)testThatOperationCompletesSuccessfully {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    NSDictionary *inputData = [NSDictionary new];
    [self setInputData:inputData
          forOperation:self.operation];
    
    OperationBuffer *outputBuffer = [OperationBuffer buffer];
    self.operation.output = outputBuffer;
    
    id mockDelegate = OCMProtocolMock(@protocol(ChainableOperationDelegate));
    self.operation.delegate = mockDelegate;
    
    NSDictionary *outputData = [NSDictionary new];
    OCMStub([self.mockResponseConverter convertFromResponse:inputData]).andReturn(outputData);
    
    [self.operation setCompletionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [expectation fulfill];
        });
    }];
    
    // when
    [self.operation start];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        id resultData = [outputBuffer obtainInputDataWithTypeValidationBlock:nil];
        XCTAssertNotNil(resultData);
        OCMVerify([mockDelegate didCompleteChainableOperationWithError:nil]);
        XCTAssertTrue(self.operation.finished);
    }];
}

@end
