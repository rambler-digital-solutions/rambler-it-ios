//
//  RCFNetworkClient.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RCFNetworkClientCompletionBlock)(NSData *data, NSError *error);

/**
 @author Egor Tolstoy
 
 This protocol describes a universal network client, which is responsible for sending NSURLRequests and receiving the server response as a raw data.
 */
@protocol RCFNetworkClient <NSObject>

/**
 @author Egor Tolstoy
 
 This asynchronyous method initiates sending the provided NSURLRequest to some server and receiving its response as NSData object.
 
 @param request  The NSURLRequest containing all the necessary information (target URL, HTTP headers, request body, etc) for performing the request.
 @param block    The block, which is called when the response data is received.
 */
- (void)sendRequest:(NSURLRequest *)request
    completionBlock:(RCFNetworkClientCompletionBlock)block;

@end
