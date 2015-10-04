//
//  RCFManagedObjectMapper.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RCFResponseMapper.h"

@class RCFManagedObjectMappingProvider;

/**
 @author Egor Tolstoy
 
 It's an object for mapping server responses into a specific NSManagedObjects
 */
@interface RCFManagedObjectMapper : NSObject <RCFResponseMapper>

/**
 @author Egor Tolstoy
 
 The main initializer of RCFManagedObjectMapper
 
 @param mappingProvider This provider is used to retrieve a mapping for a given NSManagedObject class name
 
 @return RCFManagedObjectMapper
 */
- (instancetype)initWithMappingProvider:(RCFManagedObjectMappingProvider *)mappingProvider;

@end
