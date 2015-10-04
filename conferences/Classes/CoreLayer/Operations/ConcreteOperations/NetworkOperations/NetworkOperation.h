//
//  NetworkOperation.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "AsyncOperation.h"

#import "ChainableOperation.h"

@protocol RCFNetworkClient;

/**
 @author Egor Tolstoy
 
 The operation is responsible for sending preconfigured NSURLRequest to the remote server and receiving back some response.
 */
@interface NetworkOperation : AsyncOperation <ChainableOperation>

+ (instancetype)operationWithNetworkClient:(id<RCFNetworkClient>)networkClient;

@end
