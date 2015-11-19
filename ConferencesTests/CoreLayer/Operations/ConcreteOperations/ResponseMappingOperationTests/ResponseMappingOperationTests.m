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

#import "ResponseMappingOperation.h"
#import "ResponseMapper.h"

@interface ResponseMappingOperationTests : ChainableOperationTestsBase

@property (strong, nonatomic) ResponseMappingOperation *operation;
@property (strong, nonatomic) id mockResponseMapper;

@end

@implementation ResponseMappingOperationTests

- (void)setUp {
    [super setUp];
    
    self.mockResponseMapper = OCMProtocolMock(@protocol(ResponseMapper));
    self.operation = [ResponseMappingOperation operationWithResponseMapper:self.mockResponseMapper
                                                            mappingContext:nil];
}

- (void)tearDown {
    self.mockResponseMapper = nil;
    self.operation = nil;
    
    [super tearDown];
}

- (void)testThatOperationCallsConfiguratorOnExecute {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    NSDictionary *inputData = @{
                                @"key" : @"value"
                                };
    [self setInputData:inputData forOperation:self.operation];
    [self stubMapperWithData:nil error:nil];
    
    [self.operation setCompletionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [expectation fulfill];
        });
    }];
    
    // when
    [self.operation start];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout handler:^(NSError *error) {
        [[[self.mockResponseMapper verify] ignoringNonObjectArgs] mapServerResponse:OCMOCK_ANY withMappingContext:OCMOCK_ANY error:nil];
    }];
}

- (void)testThatOperationSetsOutputOnSuccess {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    NSDictionary *inputData = @{
                                @"key" : @"value"
                                };
    [self stubMapperWithData:inputData error:nil];
    [self setInputData:inputData forOperation:self.operation];
    
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
        OCMVerify([self.operation.output didCompleteChainableOperationWithOutputData:inputData]);
        OCMVerify([mockDelegate didCompleteChainableOperationWithError:nil]);
        XCTAssertTrue(self.operation.isFinished);
    }];
}

- (void)stubMapperWithData:(NSDictionary *)data error:(NSError *)error {
    [[[[self.mockResponseMapper stub] ignoringNonObjectArgs] mapServerResponse:OCMOCK_ANY withMappingContext:OCMOCK_ANY error:nil] andReturn:data];
}

@end
