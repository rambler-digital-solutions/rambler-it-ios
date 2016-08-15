//
//  DeletedObjectsMapper.h
//  Conferences
//
//  Created by k.zinovyev on 15.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseObjectFormatter.h"

@class ManagedObjectMappingProvider;
@protocol ResponseObjectFormatter;
@protocol EntityNameFormatter;

@interface DeletedObjectsMapper : NSObject

@property (strong, nonatomic) id<ResponseObjectFormatter> deletedResponseFormatter;
@property (strong, nonatomic, readonly) ManagedObjectMappingProvider *provider;
@property (strong, nonatomic, readonly) id<EntityNameFormatter> entityNameFormatter;

- (instancetype)initWithMappingProvider:(ManagedObjectMappingProvider *)mappingProvider
                responseObjectFormatter:(id <ResponseObjectFormatter>)responseFormatter
                    entityNameFormatter:(id<EntityNameFormatter>)entityNameFormatter;

@end
