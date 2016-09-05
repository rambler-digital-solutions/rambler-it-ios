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

@class NITableViewModel;
@class NICollectionViewModel;
@class TagCellSizeCalculator;
@protocol TagDataDisplayManagerDelegate;


@interface TagDataDisplayManager : NSObject <UICollectionViewDelegateFlowLayout>

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