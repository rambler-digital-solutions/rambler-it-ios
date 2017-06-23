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

#import "ChainableOperationInput.h"
#import "ChainableOperationOutput.h"
#import "CompoundOperationQueueInput.h"
#import "CompoundOperationQueueOutput.h"

/**
 @author Egor Tolstoy
 
 The mediator class between compound operation's elements.
 
 We are using it to reduce coupling between two suboperations. It allows us to build any possible combination with different suboperations unawared of each other.
 Besides it, this buffer is used to chain the compound operation with the first and last suboperations from its queue.
 */
@interface OperationBuffer : NSObject <ChainableOperationInput, ChainableOperationOutput, CompoundOperationQueueInput, CompoundOperationQueueOutput>

+ (instancetype)buffer;

@end
