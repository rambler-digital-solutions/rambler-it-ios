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
