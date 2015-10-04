//
//  RequestConfigurationOperation.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "AsyncOperation.h"

#import "ChainableOperation.h"

@protocol RCFRequestConfigurator;

/**
 @author Egor Tolstoy
 
 The operation is responsible for configuring a NSURLRequest using the provided information
 */
@interface RequestConfigurationOperation : AsyncOperation <ChainableOperation>

+ (instancetype)operationWithRequestConfigurator:(id<RCFRequestConfigurator>)configurator
                                          method:(NSString *)method
                                     serviceName:(NSString *)serviceName
                                   urlParameters:(NSArray *)urlParameters;

@end
