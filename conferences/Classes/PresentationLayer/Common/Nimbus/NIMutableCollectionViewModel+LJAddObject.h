//
// NIMutableCollectionViewModel+LJAddObject.h
// LiveJournal
// 
// Created by Golovko Mikhail on 30/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "NIMutableCollectionViewModel.h"

@interface NIMutableCollectionViewModel (LJAddObject)

/**
 @author Golovko Mikhail
 
 Метод добавляет коллекцию объектов в секцию
 
 @param array   Добавляемые объекты
 @param section Секция в которую добавляем
 
 @return Индексы добавленных объектов
 */
- (NSArray *)addObjectsFromArray:(NSArray *)array toSection:(NSUInteger)section;

@end