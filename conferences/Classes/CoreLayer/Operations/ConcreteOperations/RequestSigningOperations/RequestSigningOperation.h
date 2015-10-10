//
//  RequestSigningOperation.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "AsyncOperation.h"

#import "ChainableOperation.h"

@protocol RequestSigner;
@protocol Session;

/**
 @author Egor Tolstoy
 
 The operation is responsible for signing a preconfigured NSURLRequest with some authorization data
 */
@interface RequestSigningOperation : AsyncOperation <ChainableOperation>

+ (instancetype)operationWithRequestSigner:(id<RequestSigner>)signer;

@end
