//
// TagCellDelegate.h
// LiveJournal
// 
// Created by Golovko Mikhail on 23/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TagCollectionViewCellObject;

@protocol TagCellDelegate <NSObject>

/**
 @author Golovko Mikhail
 
 Метод вызывается, когда на ячейки была нажата кнопка удалить тег
 
 @param cellObject Модель ячейки, для которой была нажата кнопка
 */
- (void)didTapRemoveTag:(TagCollectionViewCellObject *)cellObject;

@end