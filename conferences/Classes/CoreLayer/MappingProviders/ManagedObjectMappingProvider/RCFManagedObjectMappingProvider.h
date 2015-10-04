//
//  RCFManagedObjectMappingProvider.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EKManagedObjectMapping;

/**
 @author Egor Tolstoy
 
 This class is used for storing EasyMapping mappings for all of NSManagedObjects
 */
@interface RCFManagedObjectMappingProvider : NSObject

/**
 @author Egor Tolstoy
 
 The mapping for SocialNetworkAccount class
 */
+ (EKManagedObjectMapping *)socialNetworkModelMapping;

@end
