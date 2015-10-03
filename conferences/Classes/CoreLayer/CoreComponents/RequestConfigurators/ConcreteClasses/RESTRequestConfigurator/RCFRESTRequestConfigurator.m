//
//  RCFRESTRequestConfigurator.m
//  Conferences
//
//  Created by Egor Tolstoy on 03/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "RCFRESTRequestConfigurator.h"

#import "RCFRequestDataModel.h"

@interface RCFRESTRequestConfigurator ()

@property (strong, nonatomic) NSURL *baseURL;
@property (strong, nonatomic) NSString *apiPath;

@end

@implementation RCFRESTRequestConfigurator

#pragma mark - Initialization

- (instancetype)initWithBaseURL:(NSURL *)baseURL
                        apiPath:(NSString *)apiPath {
    self = [super init];
    if (self) {
        _baseURL = baseURL;
        _apiPath = apiPath;
    }
    return self;
}

#pragma mark - RCFRequestConfigurator

- (NSURLRequest *)requestWithMethod:(NSString *)method
                        serviceName:(NSString *)serviceName
                      urlParameters:(NSArray *)urlParameters
                   requestDataModel:(RCFRequestDataModel *)requestDataModel {
    NSDictionary *queryParameters = requestDataModel.queryParameters;
    NSURL *finalURL = [self generateURLWithServiceName:serviceName
                                         urlParameters:urlParameters
                                       queryParameters:queryParameters];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:finalURL];
    
    
    
    return mutableRequest;
}

#pragma mark - Helper Methods

- (NSURL *)generateURLWithServiceName:(NSString *)serviceName
                        urlParameters:(NSArray *)urlParameters
                      queryParameters:(NSDictionary *)queryParameters {
    NSMutableArray *urlParts = [NSMutableArray new];

    [urlParts addObject:self.apiPath];
    if (serviceName) {
        [urlParts addObject:serviceName];
    }

    [urlParts addObjectsFromArray:urlParameters];
    [urlParts addObject:[self stringFromQueryParameters:queryParameters]];
    
    NSString *urlPath = [urlParts componentsJoinedByString:@"/"];
    urlPath = [self filterSlachesInURLPath:urlPath];
    
    NSURL *finalURL = [self.baseURL URLByAppendingPathComponent:urlPath];
    return finalURL;
}

- (NSString *)stringFromQueryParameters:(NSDictionary *)parameters {
    NSMutableArray *queryParts = [NSMutableArray new];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [queryParts addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
    }];
    NSString *queryString = [queryParts componentsJoinedByString:@"&"];
    return [NSString stringWithFormat:@"?%@", queryString];
}

- (NSString *)filterSlachesInURLPath:(NSString *)urlPath {
    NSString *filteredPath = [urlPath stringByReplacingOccurrencesOfString:@"?" withString:@""];
    filteredPath = [urlPath stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
    
    return filteredPath;
}

#pragma mark - Debug

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"BaseURL: %@;\napiPath: %@", self.baseURL, self.apiPath];
}

@end
