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

#import "RESTRequestConfigurator.h"

#import "RequestDataModel.h"

@interface RESTRequestConfigurator ()

@property (copy, nonatomic) NSURL *baseURL;
@property (copy, nonatomic) NSString *apiPath;

@end

@implementation RESTRequestConfigurator

#pragma mark - Initialization

- (instancetype)initWithBaseURL:(NSURL *)baseURL
                        apiPath:(NSString *)apiPath {
    self = [super init];
    if (self) {
        _baseURL = [baseURL copy];
        _apiPath = [apiPath copy];
    }
    return self;
}

#pragma mark - RCFRequestConfigurator

- (NSURLRequest *)requestWithMethod:(NSString *)method
                        serviceName:(NSString *)serviceName
                      urlParameters:(NSArray *)urlParameters
                   requestDataModel:(RequestDataModel *)requestDataModel {
    NSURL *finalURL = [self generateURLWithServiceName:serviceName
                                         urlParameters:urlParameters];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:finalURL];
    [mutableRequest setHTTPMethod:method];
    
    NSURLRequest *request;
    if (requestDataModel.bodyData) {
        [mutableRequest setHTTPBody:requestDataModel.bodyData];
        request = [mutableRequest copy];
    } else {
        request = [self requestBySerializingRequest:[mutableRequest copy]
                                     withParameters:requestDataModel.queryParameters
                                              error:nil];
    }
    
    return request;
}

#pragma mark - Helper Methods

- (NSURL *)generateURLWithServiceName:(NSString *)serviceName
                        urlParameters:(NSArray *)urlParameters {
    NSMutableArray *urlParts = [NSMutableArray new];

    [urlParts addObject:self.apiPath];
    if (serviceName) {
        [urlParts addObject:serviceName];
    }

    [urlParts addObjectsFromArray:urlParameters];
    
    NSString *urlPath = [urlParts componentsJoinedByString:@"/"];
    urlPath = [self filterSlashesInURLPath:urlPath];
    
    NSURL *finalURL = [self.baseURL URLByAppendingPathComponent:urlPath];
    return finalURL;
}

- (NSString *)filterSlashesInURLPath:(NSString *)urlPath {
    NSString *filteredPath = [urlPath stringByReplacingOccurrencesOfString:@"//"
                                                                withString:@"/"];
    
    return filteredPath;
}

#pragma mark - Debug

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"BaseURL: %@;\napiPath: %@", self.baseURL, self.apiPath];
}

@end
