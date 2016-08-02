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

#import "CommonNetworkClient.h"
#import "ServerResponseModel.h"

@interface CommonNetworkClient ()

@property (strong, nonatomic) NSURLSession *session;

@end

@implementation CommonNetworkClient

#pragma mark - Initialization

- (instancetype)initWithURLSession:(NSURLSession *)session {
    self = [super init];
    if (self) {
        _session = session;
    }
    return self;
}

#pragma mark - RCFNetworkClient

- (void)sendRequest:(NSURLRequest *)request
    completionBlock:(RCFNetworkClientCompletionBlock)block {
    NSAssert(request != nil, @"NSURLRequest should not be nil");

    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (block) {
            NSHTTPURLResponse *serverResponse = nil;
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                serverResponse = (NSHTTPURLResponse *)response;
            }
            ServerResponseModel *model = [[ServerResponseModel alloc] initWithResponse:serverResponse
                                                                                  data:data];
            block(model, error);
        }
    }];

    
    [dataTask resume];
}

#pragma mark - Debug Description

- (NSString *)debugDescription {
    return NSStringFromClass([self class]);
}

@end
