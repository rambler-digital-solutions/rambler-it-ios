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

#import "ChainableOperationTestsBase.h"

#import "RequestConfigurationOperation.h"
#import "RequestConfigurator.h"
#import "OperationBuffer.h"
#import "RequestDataModel.h"

@interface RequestConfigurationOperationTests : ChainableOperationTestsBase

@property (nonatomic, strong) RequestConfigurationOperation *operation;
@property (nonatomic, strong) id mockRequestConfigurator;

@end

@implementation RequestConfigurationOperationTests

- (void)setUp {
    [super setUp];
    
    self.mockRequestConfigurator = OCMProtocolMock(@protocol(RequestConfigurator));
    self.operation = [RequestConfigurationOperation operationWithRequestConfigurator:self.mockRequestConfigurator method:nil serviceName:nil urlParameters:nil];
}

- (void)tearDown {
    self.operation = nil;
    self.mockRequestConfigurator = nil;
    
    [super tearDown];
}

- (void)testThatOperationCallsConfiguratorOnExecute {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    RequestDataModel *dataModel = [RequestDataModel new];
    [self setInputData:dataModel forOperation:self.operation];
    
    [self.operation setCompletionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [expectation fulfill];
        });
    }];
    
    // when
    [self.operation start];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        OCMVerify([self.mockRequestConfigurator requestWithMethod:OCMOCK_ANY serviceName:OCMOCK_ANY urlParameters:OCMOCK_ANY requestDataModel:dataModel]);
    }];
    
}

- (void)testThatOperationCompletesSuccessfully {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    RequestDataModel *dataModel = [RequestDataModel new];
    [self setInputData:dataModel forOperation:self.operation];
    
    OperationBuffer *outputBuffer = [OperationBuffer buffer];
    self.operation.output = outputBuffer;
    
    id mockDelegate = OCMProtocolMock(@protocol(ChainableOperationDelegate));
    self.operation.delegate = mockDelegate;
    
    OCMStub([self.mockRequestConfigurator requestWithMethod:OCMOCK_ANY serviceName:OCMOCK_ANY urlParameters:OCMOCK_ANY requestDataModel:OCMOCK_ANY]).andReturn([NSURLRequest new]);
    
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
