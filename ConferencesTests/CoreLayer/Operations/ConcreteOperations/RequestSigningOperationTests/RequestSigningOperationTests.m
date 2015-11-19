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

#import "RequestSigningOperation.h"
#import "RequestSigner.h"
#import "OperationBuffer.h"

@interface RequestSigningOperationTests : ChainableOperationTestsBase

@property (strong, nonatomic) RequestSigningOperation *operation;
@property (strong, nonatomic) id mockRequestSigner;

@end

@implementation RequestSigningOperationTests

- (void)setUp {
    [super setUp];
    self.mockRequestSigner = OCMProtocolMock(@protocol(RequestSigner));
    
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

#pragma mark - Helper methods

- (void)stubSignerWithData:(NSURLRequest *)data {
    OCMStub([self.mockRequestSigner signRequest:OCMOCK_ANY]).andReturn(data);
}

@end
