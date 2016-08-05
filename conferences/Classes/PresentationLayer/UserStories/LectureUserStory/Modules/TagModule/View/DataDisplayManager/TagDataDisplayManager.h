//
// TagDataDisplayManager.h
// LiveJournal
// 
// Created by Golovko Mikhail on 15/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TagCellDelegate.h"

@class NITableViewModel;
@class NICollectionViewModel;
@class TagCellSizeCalculator;
@protocol TagDataDisplayManagerDelegate;


@interface TagDataDisplayManager : NSObject <TagCellDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) TagCellSizeCalculator *cellSizeCalculator;
@property (nonatomic, weak) id<TagDataDisplayManagerDelegate> delegate;

/**
 @author Golovko Mikhail
 
 Флаг включения кнопки удалить тег
 */
@property (nonatomic, assign) BOOL enableRemoveTagButton;

/**
 @author Golovko Mikhail

 Флаг сжатия ячеек по ширине.
 */
@property (nonatomic, assign) BOOL compressWidth;

/**
 @author Golovko Mikhail

 Количество отображаемых строк.
 */
@property (nonatomic, assign) NSInteger numberOfShowLine;

- (id<UICollectionViewDelegate>)delegateForCollectionView:(UICollectionView *)collectionView;

- (id<UICollectionViewDataSource>)dataSourceForCollectionView:(UICollectionView *)collectionView
                                                     withTags:(NSArray *)tags;

/**
 @author Golovko Mikhail
 
 Метод добавляет кнопку добавления тегов
 */
- (void)appendAddTagButton;

/**
 @author Golovko Mikhail
 
 Метод удаляет кнопку добавления тегов
 */
- (void)removeAddTagButton;

/**
 @author Golovko Mikhail
 
 Метод удаляет тег по индексу
 
 @param index Индекс тега
 */
- (void)removeTagAtIndex:(NSInteger)index;

/**
 @author Golovko Mikhail
 
 Метод добавляет тег
 
 @param tagName Имя тега
 */
- (void)appendTagWithName:(NSString *)tagName;

@end

@protocol TagDataDisplayManagerDelegate <NSObject>

/**
 @author Golovko Mikhail
 
 Метод вызывается, когда была нажата кнопка добавить тег.
 
 @param dataDisplayManager Отправитель
 */
- (void)dataDisplayManagerDidTapAddButton:(TagDataDisplayManager *)dataDisplayManager;

/**
 @author Golovko Mikhail
 
 Метод вызывается, когда был нажат тег
 
 @param dataDisplayManager Отправитель
 @param tagName            Имя тега
 */
- (void)dataDisplayManager:(TagDataDisplayManager *)dataDisplayManager
         didTapTagWithName:(NSString *)tagName;

/**
 @author Golovko Mikhail
 
 Метод вызывается, когда была нажата кнопка удалени тега
 
 @param dataDisplayManager Отправитель
 @param tagName            Имя тега
 @param index              Индекс тега
 */
- (void)dataDisplayManager:(TagDataDisplayManager *)dataDisplayManager
   didTapRemoveTagWithName:(NSString *)tagName
                   atIndex:(NSInteger)index;

@end