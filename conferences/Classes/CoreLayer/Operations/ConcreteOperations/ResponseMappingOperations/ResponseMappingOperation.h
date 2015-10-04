//
//  ResponseMappingOperation.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "AsyncOperation.h"

#import "ChainableOperation.h"

@protocol ResponseMapper;

/**
 @author Egor Tolstoy
 
 Операция маппинга ответа сервера
 */
@interface ResponseMappingOperation : AsyncOperation <ChainableOperation>

+ (instancetype)operationWithResponseMapper:(id<ResponseMapper>)responseMapper
                             mappingContext:(NSDictionary *)context;

@end
