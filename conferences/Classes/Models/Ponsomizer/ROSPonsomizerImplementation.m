// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ROSPonsomizerImplementation.h"

#import <objc/runtime.h>
#import <CoreData/CoreData.h>

static NSString *const ROSPONSOPostfix = @"PlainObject";
static NSString *const ROSPONSOSuperClassPrefix = @"_";
static NSString *const ROSNSMOPostfix = @"ModelObject";

NS_ASSUME_NONNULL_BEGIN

@implementation ROSPonsomizerImplementation

#pragma mark - Методы протокола <ROSPonsomizer>

- (id)convertObject:(id)object {
    return [self convertObject:object
             ignoringProperties:@[]];
}

#pragma mark - Вспомогательные методы

/**
 @author Aleksandr Sychev
 
 Преобразовывает CoreData объекты в PONSO. 
 
 @param object            NSManagedObject (или наследник) или NSArray, NSSet, NSOrderedSet, состощий из них.
 @param ignoredProperties Игнорируемые свойства преобразуемого объекта.
                          Необходимы для разрыва обратных связей и избежания циклов, при циклических связях в модели.
 
 @return PONSO-объект или NSArray, NSSet, NSOrderedSet, состоящий из PONSO-объектов.
 */
- (id)convertObject:(id)object
 ignoringProperties:(NSArray<NSString *> *)ignoredProperties {
    if ([object isKindOfClass:[NSArray class]]) {
        return [self convertCollection:object
              ignoringObjectProperties:ignoredProperties
                    mutableResultClass:[NSMutableArray class]];
    } else if ([object isKindOfClass:[NSSet class]]) {
        return [self convertCollection:object
              ignoringObjectProperties:ignoredProperties
                    mutableResultClass:[NSMutableSet class]];
    } else if ([object isKindOfClass:[NSOrderedSet class]]) {
        return [self convertCollection:object
              ignoringObjectProperties:ignoredProperties
                    mutableResultClass:[NSMutableOrderedSet class]];
    } else if ([object isKindOfClass:[NSManagedObject class]]) {
        return [self convertManagedObject:object
                       ignoringProperties:ignoredProperties];
    } else {
        return object;
    }
}

/**
 @author Aleksandr Sychev
 
 Универсальный метод для преобразования объектов коллекции
 
 @param collection         Коллекция с CoreData-объектами
 @param ignoredProperties  Игнорируемые свойства преобразуемого объекта коллекции.
                           Необходимы для разрыва обратных связей и избежания циклов, при циклических связях в модели
 @param mutableResultClass Изменяемый (мутабельный) класс результата преобразования
 
 @return Неизменяемая копия объекта класса mutableResultClass, содержащая PONSO-объекты
 */
- (id)convertCollection:(id<NSFastEnumeration>)collection
ignoringObjectProperties:(NSArray<NSString *> *)ignoredProperties
     mutableResultClass:(Class)mutableResultClass {
    id result = [mutableResultClass new];
    for (id object in collection) {
        id ponsoInstance = [self convertObject:object
                            ignoringProperties:ignoredProperties];
        [result addObject:ponsoInstance];
    }
    return [result copy];
}

- (id)convertManagedObject:(NSManagedObject *)object
        ignoringProperties:(NSArray<NSString *> *)ignoredProperties {
    NSString *modelObjectName = [NSStringFromClass([object class]) stringByReplacingOccurrencesOfString:ROSNSMOPostfix
                                                                                             withString:@""];
    NSString *ponsoClassName = [modelObjectName stringByAppendingString:ROSPONSOPostfix];
    NSString *ponsoSuperclassName = [ROSPONSOSuperClassPrefix stringByAppendingString:ponsoClassName];
    
    const char *ponsoClassNameOldCString = [ponsoClassName UTF8String];
    const char *ponsoSuperClassNameOldCString = [ponsoSuperclassName UTF8String];
    
    Class ponsoClass = objc_getClass(ponsoClassNameOldCString); // machine-generated класс PONSO
    Class ponsoSuperclass = objc_getClass(ponsoSuperClassNameOldCString); // PONSO с пользовательской логикой

    NSAssert(ponsoClass != nil, @"Не удалось найти класс %@", ponsoClassName);
    NSAssert(ponsoSuperclass != nil, @"Не удалось найти суперкласс %@", ponsoSuperclassName);

    // Строим список свойств, которые нужно игнорировать при конвертации вложенных объектов
    NSMutableArray<NSString *> *nextEntityIgnoredProperties = [ignoredProperties mutableCopy];
    NSArray<NSString *> *currentObjectIgnoringProperties = [self ignoringPropertiesOfObject:object
                                                                                 ponsoClass:ponsoSuperclass];
    [nextEntityIgnoredProperties addObjectsFromArray:currentObjectIgnoringProperties];
    
    id ponsoInstance = [ponsoClass new];
    
    unsigned int propertiesCount = 0u;
    objc_property_t *properties = class_copyPropertyList(ponsoSuperclass, &propertiesCount);
    
    for (unsigned int propertyIndex = 0u; propertyIndex < propertiesCount; ++propertyIndex) {
        objc_property_t property = properties[propertyIndex];
        const char *name = property_getName(property);
        
        /**
         @author Aleksandr Sychev
         
         Такой кастинг допустим, так как SEL это обычная C-строка.
         Использование SEL selector = NSSelectorFromString(name) невозможно, т.к. в этом случае
         readonly-поля (hash, description и т.д.) также попадают под преобразование. Почему происходит - неизвестно.
         
         @see: https://habrahabr.ru/post/250955/
         */
        SEL selector = (SEL)name;
        NSString *selectorAsString = NSStringFromSelector(selector);
        
        if ([ignoredProperties containsObject:selectorAsString]) {
            continue;
        }
        
        if ([object respondsToSelector:selector]) {
            id value = [object valueForKey:selectorAsString];
            
            id ponsoValue = [self convertObject:value
                             ignoringProperties:[nextEntityIgnoredProperties copy]];
            [ponsoInstance setValue:ponsoValue
                             forKey:selectorAsString];
        }
    }
    
    free(properties);
    
    return ponsoInstance;
}

- (NSMutableArray<NSString *> *)ignoringPropertiesOfObject:(NSManagedObject *)object
                                                ponsoClass:(Class)ponsoClass {
    NSMutableArray<NSString *> *ignoredProperties = [NSMutableArray array];
    
    unsigned int propertiesCount = 0u;
    objc_property_t *properties = class_copyPropertyList(ponsoClass, &propertiesCount);
    
    for (unsigned int propertyIndex = 0u; propertyIndex < propertiesCount; ++propertyIndex) {
        objc_property_t property = properties[propertyIndex];
        const char *name = property_getName(property);
        SEL selector = (SEL)name;
        NSString *selectorAsString = NSStringFromSelector(selector);

        if ([object respondsToSelector:selector]
            && [object isKindOfClass:[NSManagedObject class]]) {
            /**
             @author Aleksandr Sychev
             
             Обратную связь добавляем к игнорируемым
             */
            NSString *ignoredRelationship = [self inverseNameForRelationship:selectorAsString
                                                            forManagedObject:object];
            if (ignoredRelationship != nil) {
                [ignoredProperties addObject:ignoredRelationship];
            }
        }
    }
    
    return ignoredProperties;
}

- (nullable NSString *)inverseNameForRelationship:(NSString *)relationshipName
                                 forManagedObject:(NSManagedObject *)managedObject {
    
    NSString *result = nil;
    NSRelationshipDescription *relationshipDescription = [managedObject.entity relationshipsByName][relationshipName];
    if (relationshipDescription != nil) {
        result = relationshipDescription.inverseRelationship.name;
    }
    return result;
}

@end

NS_ASSUME_NONNULL_END

