//
//  ResponseDeserializationOperationTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 03/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "ChainableOperationTestsBase.h"

#import "ResponseDeserializationOperation.h"
#import "ResponseDeserializer.h"

@interface ResponseDeserializationOperationTests : ChainableOperationTestsBase

@property (strong, nonatomic) ResponseDeserializationOperation *operation;
@property (strong, nonatomic) id mockResponseDeserializer;

@end

@implementation ResponseDeserializationOperationTests

- (void)setUp {
    [super setUp];
    
    self.mockResponseDeserializer = OCMProtocolMock(@protocol(ResponseDeserializer));
    self.operation = [ResponseDeserializationOperation operationWithResponseDeserializer:self.mockResponseDeserializer];
}

- (void)tearDown {
    self.operation = nil;
    self.mockResponseDeserializer = nil;
    
    [super tearDown];
}

- (void)testThatOperationCallsConfiguratorOnExecute {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    [self stubDeserializerWithData:nil error:nil];
    [self setInputData:[NSData new] forOperation:self.operation];
    
    [self.operation setCompletionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [expectation fulfill];
        });
    }];
    
    // when
    [self.operation start];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        OCMVerify([self.mockResponseDeserializer deserializeServerResponse:OCMOCK_ANY completionBlock:OCMOCK_ANY]);
    }];
}

- (void)testThatOperationCompletesSuccessfully {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    NSDictionary *inputDictionary = @{
                                      @"key" : @"value"
                                      };
    
    [self stubDeserializerWithData:inputDictionary error:nil];
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
        OCMVerify([self.operation.output didCompleteChainableOperationWithOutputData:inputDictionary]);
        OCMVerify([mockDelegate didCompleteChainableOperationWithError:nil]);
        XCTAssertTrue(self.operation.isFinished);
    }];
}

- (void)testThatOperationCallsDelegateOnError {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    NSError *innerError = [NSError errorWithDomain:@"" code:0 userInfo:nil];
    [self stubDeserializerWithData:nil error:innerError];
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
        OCMVerify([mockDelegate didCompleteChainableOperationWithError:innerError]);
        XCTAssertTrue(self.operation.isFinished);
    }];
}

- (void)stubDeserializerWithData:(NSDictionary *)data error:(NSError *)error {
    ProxyBlock proxyBlock = ^(NSInvocation *invocation) {
        RCFResponseDeserializerCompletionBlock completionBlock;
        [invocation getArgument:&completionBlock atIndex:3];
        
        completionBlock(data, error);
    };
    OCMStub([self.mockResponseDeserializer deserializeServerResponse:OCMOCK_ANY completionBlock:OCMOCK_ANY]).andDo(proxyBlock);
}

@end
