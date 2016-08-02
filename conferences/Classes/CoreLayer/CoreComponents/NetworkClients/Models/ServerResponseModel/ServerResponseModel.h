//
//  ServerResponseModel.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 12/02/16.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 Модель, описывающая ответ сервера
 */
@interface ServerResponseModel : NSObject

@property (nonatomic, strong, readonly) NSHTTPURLResponse *response;
@property (nonatomic, strong, readonly) NSData *data;

- (instancetype)initWithResponse:(NSHTTPURLResponse *)response
                            data:(NSData *)data;

@end
