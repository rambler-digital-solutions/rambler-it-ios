//
//  RequestSigningOperationTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "ChainableOperationTestsBase.h"

#import "RequestSigningOperation.h"
#import "RCFRequestSigner.h"
#import "OperationBuffer.h"

@interface RequestSigningOperationTests : ChainableOperationTestsBase

@property (strong, nonatomic) RequestSigningOperation *operation;
@property (strong, nonatomic) id mockRequestSigner;

@end

@implementation RequestSigningOperationTests

- (void)setUp {
    [super setUp];
    self.mockRequestSigner = OCMProtocolMock(@protocol(RCFRequestSigner));
    
    self.operation = [RequestSigningOperation operationWithRequestSigner:self.mockRequestSigner];
}

- (void)tearDown {
    self.mockRequestSigner = nil;
    self.operation = nil;
    
    [super tearDown];
}

- (void)testThatOperationCallsSignerOnExecute {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    NSURLRequest *inputData = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://rambler.ru"]];
    [self setInputData:inputData forOperation:self.operation];
    [self stubSignerWithData:nil];
    [self.operation setCompletionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [expectation fulfill];
        });
    }];
    
    // when
    [self.operation start];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        OCMVerify([self.mockRequestSigner signRequest:OCMOCK_ANY]);
    }];
}

- (void)testThatOperationCompletesSuccessfully {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    NSURLRequest *inputData = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://rambler.ru"]];
    [self setInputData:inputData forOperation:self.operation];
    [self setOutputData:nil forOperation:self.operation];
    [self stubSignerWithData:[NSURLRequest new]];
    
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
        [self verifyNotNilResultForOperation:self.operation];
        OCMVerify([mockDelegate didCompleteChainableOperationWithError:nil]);
        XCTAssertTrue(self.operation.finished);
    }];
}

#pragma mark - Вспомогательные методы

- (void)stubSignerWithData:(NSURLRequest *)data {
    OCMStub([self.mockRequestSigner signRequest:OCMOCK_ANY]).andReturn(data);
}

@end
