//
// TagServicePredicateBuilder.h
// LiveJournal
// 
// Created by Golovko Mikhail on 24/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TagObjectDescriptor;

/**
 @author Golovko Mikhail
 
 Билдер предикатов из TagObjectDescriptor.
 */
@interface TagServicePredicateBuilder : NSObject

/**
 @author Golovko Mikhail
 
 Метод создаёт предикат для получения тегов, которые отсутствуют в объекте objectDescriptor.
 
 @param objectDescriptor Информация об объекте, чьи теги нужно исключить.
 
 @return Предикат.
 */
- (NSPredicate *)buildExcludeTagsByNames:(NSArray *)tags;

/**
 @author Golovko Mikhail

 Метод создаёт предикат для получения объекта по objectDescriptor.

 @param objectDescriptor Инфомарция об объекте.

 @return Предикат.
 */
- (NSPredicate *)buildGetObjectPredicateFromObjectDescriptor:(TagObjectDescriptor *)objectDescriptor;

@end