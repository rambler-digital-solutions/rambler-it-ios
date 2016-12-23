//
//  RamblerTyphoonAssemblyTestUtilities.h
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RamblerPropertyType) {
    RamblerId,
    RamblerBlock,
    RamblerClass,
    RamblerProtocol,
    RamblerPrimitive
};

@class RamblerTyphoonAssemblyTestsTypeDescriptor;

/**
 @author Egor Tolstoy

 This class provides a number of useful methods for testing objects, created with a TyphoonAssembly
 */
@interface RamblerTyphoonAssemblyTestUtilities : NSObject

/**
 Returns all of the target class properties, including base classes properties.

 @param objectClass The target class

 @return NSDictionary
 */
+ (NSDictionary *)propertiesForHierarchyOfClass:(Class)objectClass;

/**
 Method converts property type string to RamblerPropertyType

 @param propertyTypeString Property Type
 @return RamblerPropertyType
 */
+ (RamblerPropertyType)propertyTypeByString:(NSString *)propertyTypeString;

/**
 Method converts property type string to RamblerTyphoonAssemblyTestsTypeDescriptor

 @param property Property Type
 @return Type Descriptor
 */
+ (RamblerTyphoonAssemblyTestsTypeDescriptor *)typeDescriptorFromPropertyWithProtocol:(NSString *)property;

/**
 Return setter selector for property

 @param propertyName Property name, for which to get setter selector
 @param clazz Class
 @return setter selector
 */
+ (SEL)setterForPropertyWithName:(NSString *)propertyName inClass:(Class)clazz;

@end
