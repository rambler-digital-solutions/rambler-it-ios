//
// TagTextFilter.h
// LiveJournal
// 
// Created by Golovko Mikhail on 04/02/16.
// Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 @author Golovko Mikhail
 
 Класс для фильтрации тегов по имени.
 */
@interface TagTextFilter : NSObject

/**
 @author Golovko Mikhail
 
 Метод устанавливает теги для фильтрации.
 
 @param tags Массив тегов.
 */
- (void)setupTagsForFiltering:(NSArray *)tags;

/**
 @author Golovko Mikhail
 
 Метод фильтрует теги по имени.
 
 @param name Имя фильтрации
 
 @return Отфильтрованный массив тегов.
 */
- (NSArray *)obtainTagsFilteredByName:(NSString *)name;

@end