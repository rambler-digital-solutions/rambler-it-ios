//
//  LastModifiedMapperOperation.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 15/02/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "AsyncOperation.h"

#import "ChainableOperation.h"

/**
 @author Egor Tolstoy
 
 Операция, реализующая логику маппинга заголовка ответа сервера в категорию постов
 */
@interface LastModifiedMapperOperation : AsyncOperation <ChainableOperation>

+ (instancetype)operationWithDateFormatter:(NSDateFormatter *)dateFormatter modelObjectId:(NSString *)modelObjectId;

@end
