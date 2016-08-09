//
// TagModuleTableViewCell.h
// LiveJournal
// 
// Created by Golovko Mikhail on 15/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NICellFactory.h"
#import "NITyphoonInjectableCell.h"
#import "TagModuleOutput.h"
#import "ContentSizeObserver.h"

@protocol TagModuleInput;
@class ContentSizeObserver;

/**
 @author Golovko Mikhail
 
 Ячейка отображения тегов.
 */
@interface TagModuleTableViewCell : UITableViewCell <NICell, NITyphoonInjectableCell, ContentSizeObserverDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView<TagModuleInput> *tagCollectionView;
@property (nonatomic, strong) ContentSizeObserver *sizeObserver;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *collectionViewWidthConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *collectionViewLeadingConstraint;

@end


@protocol TagTableViewCellDelegate

/**
 @author Vadim Smal
 
 Метод вызывается, когда размеры коллекции поменялись
 
 @param collectionView Коллекция, размеры которой поменялись.
 @param cell           Ячейка с коллекцией
 */
- (void)collectionViewDidChangeContentSize:(UICollectionView *)collectionView
                                      cell:(UITableViewCell *)cell;

@end