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
