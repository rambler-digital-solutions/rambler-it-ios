//
//  ResponseValidationOperation.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "AsyncOperation.h"

#import "ChainableOperation.h"

@protocol RCFResponseValidator;

/**
 @author Egor Tolstoy
 
 Операция валидации ответа сервера
 */
@interface ResponseValidationOperation : AsyncOperation <ChainableOperation>

+ (instancetype)operationWithResponseValidator:(id<RCFResponseValidator>)responseValidator;

@end
