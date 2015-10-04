//
//  OperationChainer.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChainableOperation;
@class OperationBuffer;
@class CompoundOperationBase;

/**
 @author Egor Tolstoy
 
 This object is responsible for chaining serial operations
 */
@interface OperationChainer : NSObject

/**
 @author Egor Tolstoy
 
 The chaining of two operations consists of two actual procedures:
 - We add dependency for the child operation on the parent operation
 - The provided buffer is used as the output of the parent operation and input of the child operation
 */
- (void)chainParentOperation:(NSOperation <ChainableOperation> *)parentOperation
          withChildOperation:(NSOperation <ChainableOperation> *)childOperation
                  withBuffer:(OperationBuffer *)buffer;

/**
 @author Egor Tolstoy
 
 This method chains a compound operation with its operation queue
 
 @param compoundOperation        The target compound operation
 @param chainableOperationsQueue An array of suboperations, which will be put into the compound operation inner NSOperationQueue
 */
- (void)chainCompoundOperation:(CompoundOperationBase *)compoundOperation
   withChainableOperationsQueue:(NSArray <NSOperation<ChainableOperation> *> *)chainableOperationsQueue;

@end
