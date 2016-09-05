//
// CollectionViewContentCellAnimator.h
// LiveJournal
// 
// Created by Golovko Mikhail on 16/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @author Golovko Mikhail
 
 Класс, для обновления таблицы, когда СollectionView в ячейки, поменяла свой размер.
 */
@interface CollectionViewContentCellAnimator : NSObject

@property (nonatomic, weak) IBOutlet UITableView *tableView;

/**
 @author Golovko Mikhail
 
 Метод обновляет таблицу, когда CollectionView поменяла свой размер.
 
 @param collectionView CollectionView, который лежит в ячейки табилцы.
 @param Ячейка таблицы с CollectionView
 */
- (void)animateChangeCellSizeFromCollectionView:(UICollectionView *)collectionView
                                           cell:(UITableViewCell *)cell;

@end