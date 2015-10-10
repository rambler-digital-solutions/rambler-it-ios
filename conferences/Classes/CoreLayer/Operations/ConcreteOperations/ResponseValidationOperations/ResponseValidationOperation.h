//
//  ResponseValidationOperation.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "AsyncOperation.h"

#import "ChainableOperation.h"

@protocol ResponseValidator;

/**
 @author Egor Tolstoy
 
 The operation is responsible for validating deserialized server response
 */
@interface ResponseValidationOperation : AsyncOperation <ChainableOperation>

+ (instancetype)operationWithResponseValidator:(id<ResponseValidator>)responseValidator;

@end
