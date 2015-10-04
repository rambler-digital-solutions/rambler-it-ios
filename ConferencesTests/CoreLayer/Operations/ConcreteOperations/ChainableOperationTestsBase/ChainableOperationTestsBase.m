//
//  ChainableOperationTestsBase.m
//  Conferences
//
//  Created by Egor Tolstoy on 03/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "ChainableOperationTestsBase.h"

#import "ChainableOperation.h"
#import "OperationBuffer.h"

@implementation ChainableOperationTestsBase

- (void)setInputData:(id)data forOperation:(NSOperation<ChainableOperation> *)operation {
    OperationBuffer *inputBuffer = [OperationBuffer buffer];
    [inputBuffer didCompleteChainableOperationWithOutputData:data];
    operation.input = inputBuffer;
}

- (void)setOutputData:(id)data forOperation:(NSOperation<ChainableOperation> *)operation {
    OperationBuffer *outputBuffer = [OperationBuffer buffer];
    [outputBuffer didCompleteChainableOperationWithOutputData:data];
    operation.output = outputBuffer;
}

- (void)verifyNotNilResultForOperation:(NSOperation<ChainableOperation> *)operation {
    OperationBuffer *buffer = (OperationBuffer *)operation.output;
    id result = [buffer obtainInputDataWithTypeValidationBlock:nil];
    XCTAssertNotNil(result);
}

@end
