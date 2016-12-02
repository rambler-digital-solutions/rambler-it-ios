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

#import "RequestSigner.h"

@protocol RCFParseCredentialProvider;

/**
 @author Egor Tolstoy
 
 A RequestSigner responsible for signing requests to Parse.com REST API. It includes two fields on the request's http headers:
   - X-Parse-Application-Id, it identifies which application we are accessing
   - X-Parse-REST-API-Key, it authenticates the endpoint
 */
@interface ParseRequestSigner : NSObject <RequestSigner>

@property (copy, nonatomic, readonly) NSString *applicationId;
@property (copy, nonatomic, readonly) NSString *apiKey;

/**
 @author Egor Tolstoy
 
 The main initializer of the ParseRequestSigner
 
 @param applicationId X-Parse-Application-Id, it identifies which application we are accessing
 @param apiKey        X-Parse-REST-API-Key, it authenticates the endpoint
 
 @return RCFParseRequestSigner
 */
- (instancetype)initWithApplicationId:(NSString *)applicationId
                               apiKey:(NSString *)apiKey;

@end
