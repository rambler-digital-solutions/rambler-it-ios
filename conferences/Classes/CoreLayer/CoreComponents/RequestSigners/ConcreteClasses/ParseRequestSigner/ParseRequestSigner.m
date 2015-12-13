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
#import "ParseRequestSigner.h"

static NSString *const kParseApplicationIdHeader = @"X-Parse-Application-Id";
static NSString *const kParseApiKeyHeader = @"X-Parse-REST-API-Key";

@interface ParseRequestSigner ()

@property (strong, nonatomic) NSString *applicationId;
@property (strong, nonatomic) NSString *apiKey;

@end

@implementation ParseRequestSigner

#pragma mark - Initialization

- (instancetype)initWithApplicationId:(NSString *)applicationId
                               apiKey:(NSString *)apiKey {
    self = [super init];
    if (self) {
        _applicationId = applicationId;
        _apiKey = apiKey;
    }
    return self;
}

#pragma mark - RCFRequestSigner

- (NSURLRequest *)signRequest:(NSURLRequest *)request {
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    [mutableRequest setValue:self.applicationId
          forHTTPHeaderField:kParseApplicationIdHeader];
    [mutableRequest setValue:self.apiKey
          forHTTPHeaderField:kParseApiKeyHeader];
    
    return [mutableRequest copy];
}

#pragma mark - Debug Description

- (NSString *)debugDescription {
    return NSStringFromClass([self class]);
}

@end
