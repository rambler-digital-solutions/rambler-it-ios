//
//  ResponseDeserializationOperation.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "AsyncOperation.h"

#import "ChainableOperation.h"

@protocol RCFResponseDeserializer;

/**
 @author Egor Tolstoy
 
 Операция десериализации ответа сервера
 */
@interface ResponseDeserializationOperation : AsyncOperation <ChainableOperation>

+ (instancetype)operationWithResponseDeserializer:(id<RCFResponseDeserializer>)responseDeserializer;

@end
