//
//  OperationChainer.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "OperationChainer.h"

#import "OperationBuffer.h"
#import "CompoundOperationBase.h"
#import "ChainableOperation.h"

@implementation OperationChainer

- (void)chainParentOperation:(NSOperation<ChainableOperation> *)parentOperation withChildOperation:(NSOperation<ChainableOperation> *)childOperation withBuffer:(OperationBuffer *)buffer {
    [childOperation addDependency:parentOperation];
    
    parentOperation.output = buffer;
    childOperation.input = buffer;
}

- (void)chainCompoundOperation:(CompoundOperationBase *)compoundOperation withChainableOperationsQueue:(NSArray<NSOperation<ChainableOperation> *> *)chainableOperationsQueue {
    NSOperation <ChainableOperation> *firstSuboperation = [chainableOperationsQueue firstObject];
    NSOperation <ChainableOperation> *lastSuboperation = [chainableOperationsQueue lastObject];
    
    OperationBuffer *firstBuffer = [OperationBuffer buffer];
    OperationBuffer *lastBuffer = [OperationBuffer buffer];
    
    compoundOperation.queueInput = firstBuffer;
    firstSuboperation.input = firstBuffer;
    
    lastSuboperation.output = lastBuffer;
    compoundOperation.queueOutput = lastBuffer;
}

@end
