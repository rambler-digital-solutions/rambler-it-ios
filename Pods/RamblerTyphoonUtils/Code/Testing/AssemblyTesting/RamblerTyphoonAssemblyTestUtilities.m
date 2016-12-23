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
#import "RamblerTyphoonAssemblyTestsTypeDescriptor.h"

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

+ (RamblerPropertyType)propertyTypeByString:(NSString *)propertyTypeString {
    if ([propertyTypeString isEqualToString:@"?"]) {
        return RamblerBlock;
    }
    
    if ([propertyTypeString isEqualToString:@""]) {
        return RamblerPrimitive;
    }
    
    if ([propertyTypeString isEqualToString:@"id"]) {
        return RamblerId;
    }
    
    if ([propertyTypeString rangeOfString:@"<"].length != 0 ) {
        return RamblerProtocol;
    }
    
    return RamblerClass;
}

+ (RamblerTyphoonAssemblyTestsTypeDescriptor *)typeDescriptorFromPropertyWithProtocol:(NSString *)property {
    NSUInteger classNameProtocolsNamesSeparatorIndex = [property rangeOfString:@"<"].location;
    
    /**
     @author Aleksandr Sychev
     
     Find out property class
     */
    NSRange propertyClassNameSubstringRange = NSMakeRange(0u, classNameProtocolsNamesSeparatorIndex);
    NSString *propertyClassNameSubstring = [property substringWithRange:propertyClassNameSubstringRange];
    Class propertyClass = NSClassFromString(propertyClassNameSubstring);
    
    /**
     @author Aleksandr Sychev
     
     Find out property protocols
     */
    NSString *propertyProtocolsNamesSubstring = [property substringFromIndex:classNameProtocolsNamesSeparatorIndex];
    NSRange searchedRange = NSMakeRange(0u, propertyProtocolsNamesSubstring.length);
    NSString *pattern = @"<(.*?)>";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:0u
                                                                             error:NULL];
    NSMutableArray *protocols = [NSMutableArray new];
    [regex enumerateMatchesInString:propertyProtocolsNamesSubstring
                            options:0u
                              range:searchedRange
                         usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                             NSRange range = [result rangeAtIndex:1u];
                             NSString *protocolName = [propertyProtocolsNamesSubstring substringWithRange:range];
                             if (protocolName.length > 0u) {
                                 [protocols addObject:NSProtocolFromString(protocolName)];
                             }
                         }];
    
    return [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:propertyClass
                                                             andProtocols:[protocols copy]];
}

+ (SEL)setterForPropertyWithName:(NSString *)propertyName inClass:(Class)clazz {
    SEL setterSelector = nil;
    
    objc_property_t property = class_getProperty(clazz, [propertyName cStringUsingEncoding:NSASCIIStringEncoding]);
    if (property) {
        if (![self isReadonlyProperty:property]) {
            NSString *selectorString = [self customSetterForProperty:property];
            if (!selectorString) {
                selectorString = [self defaultSetterForPropertyWithName:propertyName];
            }
            setterSelector = NSSelectorFromString(selectorString);
        }
    }
    else if (propertyName.length > 0) {
        NSString *selectorString = [self defaultSetterForPropertyWithName:propertyName];
        SEL aSelector = NSSelectorFromString(selectorString);
        if (class_getInstanceMethod(clazz, aSelector)) {
            setterSelector = aSelector;
        }
    }
    
    return setterSelector;
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

+ (BOOL)isReadonlyProperty:(objc_property_t)property
{
    char *readonlyFlag = property_copyAttributeValue(property, "R");
    BOOL isReadonly = readonlyFlag != NULL;
    free(readonlyFlag);
    return isReadonly;
}

+ (NSString *)customSetterForProperty:(objc_property_t)property
{
    NSString *customSetter = nil;
    
    char *setterName = property_copyAttributeValue(property, "S");
    
    if (setterName != NULL) {
        customSetter = [NSString stringWithCString:setterName encoding:NSASCIIStringEncoding];;
        free(setterName);
    }
    
    return customSetter;
}

+ (NSString *)defaultSetterForPropertyWithName:(NSString *)propertyName
{
    NSString *firstLetterUppercase = [[propertyName substringToIndex:1] uppercaseString];
    NSString *propertyPart = [propertyName stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                                                   withString:firstLetterUppercase];
    return [NSString stringWithFormat:@"set%@:", propertyPart];
}


@end
