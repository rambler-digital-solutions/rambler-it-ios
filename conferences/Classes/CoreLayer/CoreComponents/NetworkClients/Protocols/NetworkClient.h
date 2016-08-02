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

@class ServerResponseModel;

typedef void(^RCFNetworkClientCompletionBlock)(ServerResponseModel *respodeModel, NSError *error);

/**
 @author Egor Tolstoy
 
 This protocol describes a universal network client, which is responsible for sending NSURLRequests and receiving the server response as a raw data.
 */
@protocol NetworkClient <NSObject>

/**
 @author Egor Tolstoy
 
 This asynchronyous method initiates sending the provided NSURLRequest to some server and receiving its response as NSData object.
 
 @param request  The NSURLRequest containing all the necessary information (target URL, HTTP headers, request body, etc) for performing the request.
 @param block    The block, which is called when the response data is received.
 */
- (void)sendRequest:(NSURLRequest *)request
    completionBlock:(RCFNetworkClientCompletionBlock)block;

@end
