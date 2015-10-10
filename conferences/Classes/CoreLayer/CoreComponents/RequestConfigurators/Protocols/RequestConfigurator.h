//
//  RequestConfigurator.h
//  Conferences
//
//  Created by Egor Tolstoy on 03/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RequestDataModel;

/**
 @author Egor Tolstoy
 
 This protocol describes the functionality of request configurators - objects, that are responsible for serializing NSURLRequest from a number of input parameters.
 */
@protocol RequestConfigurator <NSObject>

/**
 @author Egor Tolstoy
 
 This method return a serialized NSURLRequest for a URL, specified during the instantiation of a concrete RequestConfigurator.
 
 @param method           HTTP method name
 @param serviceName      The name of the API service (e.g. the Entity name)
 @param urlParameters    Other parts of the URL (e.g. specific object identifier)
 @param requestDataModel The model containing query/body payload
 
 @return A serialized NSURLRequest
 */
- (NSURLRequest *)requestWithMethod:(NSString *)method
                        serviceName:(NSString *)serviceName
                      urlParameters:(NSArray *)urlParameters
                   requestDataModel:(RequestDataModel *)requestDataModel;

@end
