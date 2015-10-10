//
//  CommonNetworkClient.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NetworkClient.h"

/**
 @author Egor Tolstoy
 
 A very simple network client, which just sends preconfigured NSURLRequests and processes received raw data up the chain.
 */
@interface CommonNetworkClient : NSObject <NetworkClient>

/**
 @author Egor Tolstoy
 
 The main initializer of CommonNetworkClient
 
 @param session The NSURLSession object used for sending requests
 
 @return CommonNetworkClient
 */
- (instancetype)initWithURLSession:(NSURLSession *)session;

@end