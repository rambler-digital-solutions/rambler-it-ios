//
//  RCFRequestSigner.h
//  Conferences
//
//  Created by Egor Tolstoy on 03/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RCFSession;

/**
 @author Egor Tolstoy
 
 This protocol is describing objects responsible for signing previously configured NSURLRequests with OAuth tokens or anything else.
 */
@protocol RCFRequestSigner <NSObject>

/**
 @author Egor Tolstoy
 
 The method signs a NSURLRequest using data from RCFSession object
 
 @param request Previously configurated NSURLRequest
 @param session A session object containing all necessary tokens
 
 @return Signed NSURLRequest
 */
- (NSURLRequest *)signRequest:(NSURLRequest *)request
                   forSession:(id<RCFSession>)session;

@end
