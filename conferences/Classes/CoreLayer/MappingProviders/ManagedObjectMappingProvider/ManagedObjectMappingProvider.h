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
@interface ManagedObjectMappingProvider : NSObject

/**
 @author Egor Tolstoy
 
 This method processes the provided NSManagedObject class to a specific mapping
 
 @param managedObjectModelClass The class for mapping
 
 @return EKManagedObjectMapping object
 */
- (EKManagedObjectMapping *)mappingForManagedObjectModelClass:(Class)managedObjectModelClass;

@end
