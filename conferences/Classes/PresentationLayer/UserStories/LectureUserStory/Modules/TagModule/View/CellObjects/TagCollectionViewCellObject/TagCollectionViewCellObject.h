//
// TagCollectionViewCellObject.h
// LiveJournal
// 
// Created by Golovko Mikhail on 15/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NICollectionViewCellFactory.h"

@protocol TagCellDelegate;

/**
 @author Golovko Mikhail
 
 Модель ячейки простого тега
 */
@interface TagCollectionViewCellObject : NSObject <NICollectionViewNibCellObject>

/**
 @author Golovko Mikhail
 
 Название тега
 */
@property (nonatomic, strong, readonly) NSString *tagName;

/**
 @author Golovko Mikhail

 Флаг включения кнопки удалить
 */
@property (nonatomic, assign, readonly) BOOL enableRemoveButton;

/**
 @author Golovko Mikhail

 Делегат тега
 */
@property (nonatomic, weak, readonly) id<TagCellDelegate> delegate;

- (instancetype)initWithTagName:(NSString *)tagName
             enableRemoveButton:(BOOL)enableRemoveButton
                       delegate:(id <TagCellDelegate>)delegate;

@end