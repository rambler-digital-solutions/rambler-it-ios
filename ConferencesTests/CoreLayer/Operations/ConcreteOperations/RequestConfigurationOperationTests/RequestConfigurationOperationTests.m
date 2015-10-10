//
//  RequestConfigurationOperationTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "ChainableOperationTestsBase.h"

#import "RequestConfigurationOperation.h"
#import "RequestConfigurator.h"
#import "OperationBuffer.h"
#import "RequestDataModel.h"

@interface RequestConfigurationOperationTests : ChainableOperationTestsBase

@property (strong, nonatomic) RequestConfigurationOperation *operation;
@property (strong, nonatomic) id mockRequestConfigurator;

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
