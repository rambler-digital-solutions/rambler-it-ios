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

#import "ResponseDeserializationOperation.h"
#import "ResponseDeserializer.h"

@interface ResponseDeserializationOperationTests : ChainableOperationTestsBase

@property (nonatomic, strong) ResponseDeserializationOperation *operation;
@property (nonatomic, strong) id mockResponseDeserializer;

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
