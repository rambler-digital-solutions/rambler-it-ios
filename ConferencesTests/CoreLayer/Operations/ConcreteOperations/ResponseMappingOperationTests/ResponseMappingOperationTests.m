//
//  ResponseMappingOperationTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 03/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "ChainableOperationTestsBase.h"

#import "ResponseMappingOperation.h"
#import "RCFResponseMapper.h"

@interface ResponseMappingOperationTests : ChainableOperationTestsBase

@property (strong, nonatomic) ResponseMappingOperation *operation;
@property (strong, nonatomic) id mockResponseMapper;

@end

@implementation ResponseMappingOperationTests

- (void)setUp {
    [super setUp];
    
    self.mockResponseMapper = OCMProtocolMock(@protocol(RCFResponseMapper));
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
