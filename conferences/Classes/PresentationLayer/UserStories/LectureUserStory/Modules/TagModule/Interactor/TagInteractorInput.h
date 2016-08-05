//
//  TagInteractorInput.h
//  liveJournal
//
//  Created by Golovko Mikhail on 15/12/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TagObjectDescriptor;

@protocol TagInteractorInput <NSObject>

/**
 @author Golovko Mikhail
 
 Метод запрашивает все теги у объекта.
 Метод может исключить теги, которые есть в другом объекте.
 Например, когда мы отображаем саджесты для выбора, добавленные теги нужно исключить.
 Так же можно указать префикс для фильтрации тега по имени.
 
 @param objectDescriptor        Информация об объекте
 @param excludeObjectDescriptor Информация об объекте, теги которого нужно исключить
 
 @return Теги
 */
- (NSArray *)obtainTagsFromObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                    excludeObjectDescriptor:(TagObjectDescriptor *)excludeObjectDescriptor;

/**
 @author Golovko Mikhail
 
 Метод добавляет тег объекту
 
 @param tagName          Имя нового тега
 @param objectDescriptor Информация об объекте
 */
- (void)addTagWithName:(NSString *)tagName
   forObjectDescriptor:(TagObjectDescriptor *)objectDescriptor;

/**
 @author Golovko Mikhail
 
 Метод удаляет тег у объекта
 
 @param tagName          Имя нового тега
 @param objectDescriptor Информация об объекте
 */
- (void)removeTagWithName:(NSString *)tagName
      forObjectDescriptor:(TagObjectDescriptor *)objectDescriptor;
@end