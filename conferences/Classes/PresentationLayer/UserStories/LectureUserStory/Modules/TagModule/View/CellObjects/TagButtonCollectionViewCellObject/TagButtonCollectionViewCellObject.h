//
// TagButtonCollectionViewCellObject.h
// LiveJournal
// 
// Created by Golovko Mikhail on 17/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NICollectionViewCellFactory.h"

typedef NS_ENUM(NSInteger, TagButtonType) {
    TagButtonMoreType,
    TagButtonAddTagType
};

/**
 @author Golovko Mikhail
 
 Модель ячейки коллекции для отображения кнопки.
 */
@interface TagButtonCollectionViewCellObject : NSObject <NICollectionViewNibCellObject>

/**
 @author Golovko Mikhail
 
 Заголовок кнопки.
 */
@property (nonatomic, strong, readonly) NSString *textButton;
@property (nonatomic, assign, readonly) TagButtonType type;

- (instancetype)initWithTextButton:(NSString *)textButton type:(TagButtonType)type;

@end