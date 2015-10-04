//
//  RequestConfigurationOperation.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 02/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "AsyncOperation.h"

#import "ChainableOperation.h"

@protocol RequestConfigurator;

/**
 @author Egor Tolstoy
 
 Операция создания NSURLRequest
 */
@interface RequestConfigurationOperation : AsyncOperation <ChainableOperation>

+ (instancetype)operationWithRequestConfigurator:(id<RequestConfigurator>)configurator
                                          method:(NSString *)method
                                         service:(NSNumber *)service
                                          userID:(NSString *)userID
                                   otherURLParts:(NSArray *)otherURLParts;

@end
