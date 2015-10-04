//
//  RCFParseRequestSigner.m
//  Conferences
//
//  Created by Egor Tolstoy on 03/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "RCFParseRequestSigner.h"

static NSString *const kParseApplicationIdHeader = @"X-Parse-Application-Id";
static NSString *const kParseApiKeyHeader = @"X-Parse-REST-API-Key";

@interface RCFParseRequestSigner ()

@property (strong, nonatomic) NSString *applicationId;
@property (strong, nonatomic) NSString *apiKey;

@end

@implementation RCFParseRequestSigner

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
