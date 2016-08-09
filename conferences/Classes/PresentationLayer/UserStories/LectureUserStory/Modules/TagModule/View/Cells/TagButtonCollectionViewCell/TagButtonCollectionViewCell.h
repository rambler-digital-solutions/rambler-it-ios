//
// TagButtonCollectionViewCell.h
// LiveJournal
// 
// Created by Golovko Mikhail on 17/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NICollectionViewCellFactory.h"

/**
 @author Golovko Mikhail
 
 Ячейка кнопки тега
 */
@interface TagButtonCollectionViewCell : UICollectionViewCell <NICollectionViewCell>

@property (nonatomic, weak) IBOutlet UILabel *textLabel;

@end