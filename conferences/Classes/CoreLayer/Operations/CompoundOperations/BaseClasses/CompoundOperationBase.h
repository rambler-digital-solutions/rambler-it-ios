//
//  CompoundOperationBase.h
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "AsyncOperation.h"

#import "CompoundOperationQueueInput.h"
#import "CompoundOperationQueueOutput.h"
#import "ChainableOperationDelegate.h"
#import "ChainableOperation.h"

typedef void(^CompoundOperationResultBlock)(id data, NSError *error);

/**
 @author Egor Tolstoy
 
 The base class for compound operation.
 */
@interface CompoundOperationBase : AsyncOperation <ChainableOperationDelegate>

/**
 @author Egor Tolstoy
 
 This property points, how many operations are allowed to execute in parallel.
 */
@property (assign, nonatomic) NSUInteger maxConcurrentOperationsCount;

/**
 @author Egor Tolstoy
 
 This block is called after the operation is finished.
 */
@property (copy, nonatomic) CompoundOperationResultBlock resultBlock;

/**
 @author Egor Tolstoy
 
 The buffer is used to chain the compound operation with the first suboperation from its queue.
 It can be used to pass some input data for the operations chain.
 */
@property (strong, nonatomic) id<CompoundOperationQueueInput> queueInput;

/**
 @author Egor Tolstoy
 
 The buffer is used to chain the compound operation with the last suboperation from its queue.
 It can be used to obtain the result of operations chain work.
 */
@property (strong, nonatomic) id<CompoundOperationQueueOutput> queueOutput;

/**
 @author Egor Tolstoy
 
 This method adds the provided operation to a compound operation inner queue.
 
 @param operation Chainable NSOperation
 */
- (void)addOperation:(NSOperation <ChainableOperation> *)operation;

@end
