//
//  LastModifiedMapperOperationTests.m
//  Conferences
//
//  Created by k.zinovyev on 18.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MagicalRecord/MagicalRecord.h>

#import "ChainableOperationTestsBase.h"
#import "LastModifiedMapperOperation.h"
#import "ServerResponseModel.h"
#import "OperationBuffer.h"
#import "LastModifiedModelObject.h"

static NSString *const kLastModifiedHeaderKey = @"Date";

@interface LastModifiedMapperOperationTests : ChainableOperationTestsBase

@property (nonatomic, strong) LastModifiedMapperOperation *operation;
@property (nonatomic, strong) NSDateFormatter *mockDateFormatter;
@end

@implementation LastModifiedMapperOperationTests

- (void)setUp {
    [super setUp];
    
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    
    self.mockDateFormatter = OCMClassMock([NSDateFormatter class]);
    self.operation = [LastModifiedMapperOperation operationWithDateFormatter:self.mockDateFormatter
                                                               modelObjectId:@""];
}

- (void)tearDown {
    
    self.operation = nil;
    self.mockDateFormatter = nil;
    [MagicalRecord cleanUp];
    
    [super tearDown];
}

- (void)testThatOperationCompletesSuccessfully {
    // given
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    ServerResponseModel *responseModel = OCMClassMock([ServerResponseModel class]);
    NSData *data = [NSData new];
    OCMStub(responseModel.data).andReturn(data);
    [self setInputData:responseModel
          forOperation:self.operation];
    
    OperationBuffer *outputBuffer = [OperationBuffer buffer];
    self.operation.output = outputBuffer;
    
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
        id resultData = [outputBuffer obtainInputDataWithTypeValidationBlock:nil];
        LastModifiedModelObject *modelObject = [LastModifiedModelObject MR_findFirst];
        XCTAssertNotNil(resultData);
        OCMVerify([mockDelegate didCompleteChainableOperationWithError:nil]);
        XCTAssertTrue(self.operation.finished);
        XCTAssertNotNil(modelObject);
        
        XCTAssertNotNil(modelObject.lastModifiedDate);
    }];
}

@end
