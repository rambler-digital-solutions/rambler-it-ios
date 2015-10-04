//
//  NetworkOperation.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "AsyncOperation.h"

#import "ChainableOperation.h"

@protocol NetworkClient;

/**
 @author Egor Tolstoy
 
 Операция отправки сетевого запроса на сервер
 */
@interface NetworkOperation : AsyncOperation <ChainableOperation>

+ (instancetype)operationWithNetworkClient:(id<NetworkClient>)networkClient;

@end
