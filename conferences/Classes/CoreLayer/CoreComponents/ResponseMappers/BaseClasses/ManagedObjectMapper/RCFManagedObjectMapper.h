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
@protocol RCFResponseObjectFormatter;

/**
 @author Egor Tolstoy
 
 It's an object for mapping NSArray of response objects into a specific NSManagedObjects
 */
@interface RCFManagedObjectMapper : NSObject <RCFResponseMapper>

/**
 @author Egor Tolstoy
 
 The main initializer of RCFManagedObjectMapper
 
 @param mappingProvider This provider is used to retrieve a mapping for a given NSManagedObject class name
 @param formatter       This object is used to format the concrete server response in such a way that this mapper can process them (e.g. the formatter can extract an array of objects from a @{results : @[]} dictionary.
 
 @return RCFManagedObjectMapper
 */
- (instancetype)initWithMappingProvider:(RCFManagedObjectMappingProvider *)mappingProvider
                responseObjectFormatter:(id <RCFResponseObjectFormatter>)formatter;

@end
