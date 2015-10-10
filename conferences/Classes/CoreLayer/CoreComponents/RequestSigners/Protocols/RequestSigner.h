//
//  RequestSigner.h
//  Conferences
//
//  Created by Egor Tolstoy on 03/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 This protocol is describing objects responsible for signing previously configured NSURLRequests with OAuth tokens or anything else.
 */
@protocol RequestSigner <NSObject>

/**
 @author Egor Tolstoy
 
 The method signs a NSURLRequest using data, provided by the specific signer's dependencies
 
 @param request Previously configurated NSURLRequest
 
 @return Signed NSURLRequest
 */
- (NSURLRequest *)signRequest:(NSURLRequest *)request;

@end
