//
//  ResponseMappingOperation.h
//  Conferences
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "AsyncOperation.h"

#import "ChainableOperation.h"

@protocol RCFResponseMapper;

/**
 @author Egor Tolstoy
 
 The operation is responsible for server response mapping
 */
@interface ResponseMappingOperation : AsyncOperation <ChainableOperation>

+ (instancetype)operationWithResponseMapper:(id<RCFResponseMapper>)responseMapper
                             mappingContext:(NSDictionary *)context;

@end
