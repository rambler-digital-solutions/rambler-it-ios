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

/**
 @author Egor Tolstoy
 
 This object formats the chainable NSOperation description for logging it
 */
@interface OperationDebugDescriptionFormatter : NSObject

/**
 @author Egor Tolstoy
 
 The method returns an NSString with the description of chainable operation. It consists of:
 - The operation class
 - Input data description
 - Dependencies on other operations
 - Operation state (flags)
 - Additional information
 
 @param operation      ChainableOperation
 @param additionalInfo Additional information specific for the provided operation
 
 @return Formatted debug description
 */
+ (NSString *)debugDescriptionForOperation:(NSOperation <ChainableOperation> *)operation
                        withAdditionalInfo:(NSArray *)additionalInfo;

@end
