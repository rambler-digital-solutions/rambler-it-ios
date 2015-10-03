//
//  RCFRESTRequestConfigurator.h
//  Conferences
//
//  Created by Egor Tolstoy on 03/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RCFRequestConfigurator.h"

/**
 @author Egor Tolstoy
 
 This class is intended for serializing NSURLRequests for the REST API
 */
@interface RCFRESTRequestConfigurator : NSObject <RCFRequestConfigurator>

/**
 @author Egor Tolstoy
 
 The main initializer of the RequestConfigurator
 
 @param baseURL The base URL (e.g. https://myapi.com)
 @param apiPath The path to a server endpoint (e.g. /v1/rest/)
 
 @return RCFRESTRequestConfigurator
 */
- (instancetype)initWithBaseURL:(NSURL *)baseURL
                        apiPath:(NSString *)apiPath;

@end
