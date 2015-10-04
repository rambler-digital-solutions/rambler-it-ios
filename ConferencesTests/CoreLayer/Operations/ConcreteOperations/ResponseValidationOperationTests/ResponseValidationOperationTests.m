//
//  ResponseValidationOperationTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 03/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "ChainableOperationtestsBase.h"

#import "ResponseValidationOperation.h"
#import "RCFResponseValidator.h"

@interface ResponseValidationOperationTests : ChainableOperationTestsBase

@property (strong, nonatomic) ResponseValidationOperation *operation;
@property (strong, nonatomic) id mockResponseValidator;

@end

@implementation ResponseValidationOperationTests

- (void)setUp {
    [super setUp];
    
    self.mockResponseValidator = OCMProtocolMock(@protocol(RCFResponseValidator));
    self.operation = [ResponseValidationOperation operationWithResponseValidator:self.mockResponseValidator];
}

- (void)tearDown {
    self.mockResponseValidator = nil;
    self.operation = nil;
    
    [super tearDown];
}

- (void)testThatOperationCallsConfiguratorOnExecute {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    [self setInputData:[NSDictionary new] forOperation:self.operation];
    
    [self.operation setCompletionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [expectation fulfill];
        });
    }];
    
    // when
    [self.operation start];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        OCMVerify([self.mockResponseValidator validateServerResponse:OCMOCK_ANY]);
    }];
}

- (void)testThatOperationCompletesSuccessfully {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    [self stubValidatorWithError:nil];
    [self setInputData:@{} forOperation:self.operation];
    
    id mockDelegate = OCMProtocolMock(@protocol(ChainableOperationDelegate));
    self.operation.delegate = mockDelegate;
    
    [self.operation setCompletionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [expectation fulfill];
        });
    }];
    
    // when
    [self.operation start];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        OCMVerify([self.operation.output didCompleteChainableOperationWithOutputData:@{}]);
        OCMVerify([mockDelegate didCompleteChainableOperationWithError:nil]);
        XCTAssertTrue(self.operation.isFinished);
    }];
}

- (void)testThatOperationCallsDelegateOnError {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:nil];
    [self stubValidatorWithError:error];
    [self setInputData:[NSData new] forOperation:self.operation];
    
    id mockDelegate = OCMProtocolMock(@protocol(ChainableOperationDelegate));
    self.operation.delegate = mockDelegate;
    
    [self.operation setCompletionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [expectation fulfill];
        });
    }];
    
    // when
    [self.operation start];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        OCMVerify([mockDelegate didCompleteChainableOperationWithError:OCMOCK_ANY]);
        XCTAssertTrue(self.operation.isFinished);
    }];
}

- (void)stubValidatorWithError:(NSError *)error {
    OCMStub([self.mockResponseValidator validateServerResponse:OCMOCK_ANY]).andReturn(error);
}

@end
