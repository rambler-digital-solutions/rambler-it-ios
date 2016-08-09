//
// TagService.h
// LiveJournal
// 
// Created by Golovko Mikhail on 15/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TagObjectDescriptor;

/**
 @author Golovko Mikhail
 
 Серис для работы с тегами.
 */
@protocol TagService <NSObject>

/**
 @author Golovko Mikhail
 
 Метод добавляет тег.
 
 @param tagName          Имя добавляемого тега.
 @param objectDescriptor Информация об объекте, в который нужно добавить тег.
 */
- (void)addTagWithName:(NSString *)tagName
   forObjectDescriptor:(TagObjectDescriptor *)objectDescriptor;

/**
 @author Golovko Mikhail
 
 Метод удаляет тег.
 
 @param tagName          Имя удаляемого тега.
 @param objectDescriptor Информация об объекте, у которого нужно удалить тег.
 */
- (void)removeTagWithName:(NSString *)tagName
      forObjectDescriptor:(TagObjectDescriptor *)objectDescriptor;

/**
 @author Golovko Mikhail
 
 Метод возвращает теги объекта. Можно исключить теги, которые есть в другом 
 объекте, указав excludeObjectDescriptor.
 
 @param objectDescriptor        Информация об объекте, у которого нужно получить теги.
 @param excludeObjectDescriptor Информация об объекте, чьи теги нужно исключить.
 
 @return Теги.
 */
- (NSArray *)obtainTagsFromObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                    excludeObjectDescriptor:(TagObjectDescriptor *)excludeObjectDescriptor;

@end