//
// CollectionViewContentCellAnimator.m
// LiveJournal
// 
// Created by Golovko Mikhail on 16/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "CollectionViewContentCellAnimator.h"


@implementation CollectionViewContentCellAnimator

- (void)animateChangeCellSizeFromCollectionView:(UICollectionView *)collectionView
                                           cell:(UITableViewCell *)cell {
    /**
     @author Vadim Smal
     
     Если ячейки еще нет в таблице indexPath == nil и обновлять не нужно
     */
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath) {
        /**
         @author Vadim Smal
         
         reload делать не нужно так как ячейка сбросить свое состояние (при написание поста),
         нужно только обновить размер.
         */
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
}

@end