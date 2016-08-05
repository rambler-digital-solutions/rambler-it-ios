//
// CollectionViewAnimator.h
// LiveJournal
// 
// Created by Golovko Mikhail on 17/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 @author Golovko Mikhail
 
 Класс для анимированной работы с коллекцией
 */
@interface CollectionViewAnimator : NSObject

@property (nonatomic, strong, readonly) UICollectionView *collectionView;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

+ (instancetype)animatorWithCollectionView:(UICollectionView *)collectionView;

/**
 @author Golovko Mikhail
 
 Метод позволяет анимированно изменить секции коллекции.
 
 @param insertedSectionsIndexSet Индексы секций для вставки.
 @param updatedSectionsIndexSet  Индексы секций для обновления.
 @param removedSectionsIndexSet  Индексы секций для удаления.
 @param isBatchUpdate            Пакетное обновление, т.е. всё обновится разом или по очереди.
 */
- (void)animateTableViewWithInsertedSectionsIndexSet:(NSIndexSet *)insertedSectionsIndexSet
                             updatedSectionsIndexSet:(NSIndexSet *)updatedSectionsIndexSet
                             removedSectionsIndexSet:(NSIndexSet *)removedSectionsIndexSet
                                        batchUpdates:(BOOL)isBatchUpdate;

/**
 @author Golovko Mikhail
 
 Метод позволяет анимированно изменить строки.
 
 @param insertedItemsAtIndexPaths Индексы вставляемых строк.
 @param updatedItemsAtIndexPaths  Индексы обновляемых строк.
 @param removedItemsAtIndexPaths  Индексы удаляемых строк.
 @param isBatchUpdate             Пакетное обновление.
 */
- (void)animateTableViewWithInsertedItemsAtIndexPaths:(NSArray *)insertedItemsAtIndexPaths
                               updatedItemsIndexPaths:(NSArray *)updatedItemsAtIndexPaths
                               removedItemsIndexPaths:(NSArray *)removedItemsAtIndexPaths
                                         batchUpdates:(BOOL)isBatchUpdate;

@end