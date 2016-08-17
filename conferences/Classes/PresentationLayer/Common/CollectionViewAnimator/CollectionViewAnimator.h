// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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