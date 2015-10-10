//
//  ResponseDeserializationOperation.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "AsyncOperation.h"

#import "ChainableOperation.h"

@protocol ResponseDeserializer;

/**
 @author Egor Tolstoy
 
 The operation is responsible for deserializing server raw responses
 */
@interface ResponseDeserializationOperation : AsyncOperation <ChainableOperation>

+ (instancetype)operationWithResponseDeserializer:(id<ResponseDeserializer>)responseDeserializer;

@end
