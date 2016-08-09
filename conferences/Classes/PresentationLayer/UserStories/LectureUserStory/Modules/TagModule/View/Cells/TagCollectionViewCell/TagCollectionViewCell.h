//
// TagCollectionViewCell.h
// LiveJournal
// 
// Created by Golovko Mikhail on 15/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NICollectionViewCellFactory.h"

@class TagCollectionViewCellObject;

/**
 @author Golovko Mikhail
 
 Ячейка тега
 */
@interface TagCollectionViewCell : UICollectionViewCell <NICollectionViewCell>

@property (nonatomic, weak) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingTagLabelConstraint;

/**
 @author Golovko Mikhail
 
 Метод вызывается, когда была нажата кнопка удаления тега.
 
 @param sender Отправитель.
 */
- (void)didTapRemoveButton:(id)sender;

@end