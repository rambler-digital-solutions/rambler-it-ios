//
//  RequestSigningOperation.h
//  LiveJournal
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
 
 Операция подписывания сетевого запроса
 */
@interface RequestSigningOperation : AsyncOperation <ChainableOperation>

+ (instancetype)operationWithRequestSigner:(id<RequestSigner>)signer
                                   session:(id<Session>)session;

@end
