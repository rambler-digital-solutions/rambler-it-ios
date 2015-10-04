//
//  CommonNetworkClient.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "CommonNetworkClient.h"

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
            block(data, error);
        }
    }];
    
    [dataTask resume];
}

#pragma mark - Debug Description

- (NSString *)debugDescription {
    return NSStringFromClass([self class]);
}

@end
