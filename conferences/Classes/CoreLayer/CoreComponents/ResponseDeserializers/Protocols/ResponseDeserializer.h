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

typedef void (^RCFResponseDeserializerCompletionBlock)(NSDictionary *response, NSError *error);

/**
 @author Egor Tolstoy
 
 This protocol describes an object responsible for deserializing raw response NSData to NSDictionary. It can have a number of different implementations depending on the server response format.
 */
@protocol ResponseDeserializer <NSObject>

/**
 @author Egor Tolstoy
 
 This method initiates the deserializing process of the provided NSData object.
 
 @param responseData The response data from the server
 @param block        The block which is called after the deserializing is over
 */
- (void)deserializeServerResponse:(NSData *)responseData
                  completionBlock:(RCFResponseDeserializerCompletionBlock)block;

@end
