//
//  ParseRequestSigner.h
//  Conferences
//
//  Created by Egor Tolstoy on 03/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

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

@property (strong, nonatomic, readonly) NSString *applicationId;
@property (strong, nonatomic, readonly) NSString *apiKey;

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
