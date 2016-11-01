//
//  RamblerTyphoonAssemblyTestUtilities.m
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "RamblerTyphoonAssemblyTestUtilities.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation RamblerTyphoonAssemblyTestUtilities

#pragma mark - Public

+ (NSDictionary *)propertiesForHierarchyOfClass:(Class)objectClass {
    NSMutableDictionary *properties = [NSMutableDictionary new];
    NSSet *propertyNames = [self propertiesForClass:objectClass
                                    upToParentClass:[NSObject class]];
    
    for (NSString *propertyName in propertyNames) {
        NSString *propertyType = [self obtainTypeForProperty:propertyName inClass:objectClass];
        properties[propertyName] = propertyType;
    }
    
    return [properties copy];
}

#pragma mark - Helpers

+ (NSSet *)propertiesForClass:(Class)clazz upToParentClass:(Class)parent
{
    NSMutableSet *propertyNames = [[NSMutableSet alloc] init];
    
    while (clazz && clazz != parent) {
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList(clazz, &count);
        
        for (unsigned int propertyIndex = 0; propertyIndex < count; propertyIndex++) {
            objc_property_t aProperty = properties[propertyIndex];
            NSString *propertyName = [NSString stringWithCString:property_getName(aProperty)
                                                        encoding:NSUTF8StringEncoding];
            
            [propertyNames addObject:propertyName];
        }
        
        clazz = class_getSuperclass(clazz);
        
        free(properties);
    }
    
    return propertyNames;
}

+ (NSString *)obtainTypeForProperty:(NSString *)propertyName inClass:(Class)class {
    objc_property_t propertyReflection = class_getProperty(class, [propertyName cStringUsingEncoding:NSASCIIStringEncoding]);
    NSString *typeName = @"";
    if (propertyReflection) {
        const char *attributes = property_getAttributes(propertyReflection);
        
        if (attributes == NULL) {
            return (NULL);
        }
        
        static char buffer[256];
        const char *e = strchr(attributes, ',');
        if (e == NULL) {
            return (NULL);
        }
        
        NSUInteger len = (NSUInteger) (e - attributes);
        memcpy( buffer, attributes, len );
        buffer[len] = '\0';
        
        NSString *typeCode = [NSString stringWithCString:buffer encoding:NSASCIIStringEncoding];
        if ([typeCode hasPrefix:@"T@"]) {
            NSRange typeNameRange = NSMakeRange(2, typeCode.length - 2);
            NSRange quoteRange = [typeCode rangeOfString:@"\"" options:0 range:typeNameRange locale:nil];
            if (quoteRange.length > 0) {
                typeNameRange.location = quoteRange.location + 1;
                typeNameRange.length = typeCode.length - typeNameRange.location;
                
                NSRange range = [typeCode rangeOfString:@"\"" options:0 range:typeNameRange locale:nil];
                typeNameRange.length = range.location - typeNameRange.location;
            }
            typeName = [typeCode substringWithRange:typeNameRange];
        }
    }
    return typeName;
}

@end