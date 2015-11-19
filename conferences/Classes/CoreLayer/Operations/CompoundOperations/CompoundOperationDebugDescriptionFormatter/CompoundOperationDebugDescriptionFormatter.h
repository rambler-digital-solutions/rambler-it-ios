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

@class CompoundOperationBase;

/**
 @author Egor Tolstoy
 
 This object formats the CompoundOperation description for logging it
 */
@interface CompoundOperationDebugDescriptionFormatter : NSObject

/**
 @author Egor Tolstoy
 
 The method returns an NSString with the description of compound operation. It consists of:
 - The general information:
   - The operation class
   - The inner operation queue name
   - Count of operations in the inner queue
   - Maximum concurrent operations number
 - Buffers information:
   - Input data type
   - Input data contents
   - Output data type
   - Output data contents
 - Dependencies on other NSOperations
 - State:
   - The inner queue state
   - The compound operation flags state
 - Additional information:
   - The resultBlock existance
 - Executing suboperations information:
   - Executing suboperation class
   - Executing suboperation debugDescription
 
 @param compoundOperation The provided CompoundOperationBase
 @param internalQueue     The compound operation inner queue
 
 @return Formatted debug description
 */
+ (NSString *)debugDescriptionForCompoundOperation:(CompoundOperationBase *)compoundOperation
                                 withInternalQueue:(NSOperationQueue *)internalQueue;

@end
