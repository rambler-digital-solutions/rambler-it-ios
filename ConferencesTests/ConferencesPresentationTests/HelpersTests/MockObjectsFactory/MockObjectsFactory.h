//
//  MockObjectsFactory.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 15/10/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostPlainObject;
@class CommentPlainObject;
@class PostViewModel;
@class NewPostViewModel;
@class MediaItemPlainObject;
@class MediaItemViewModel;

/**
 @author Egor Tolstoy
 
 Объект генерирует различные моковые сущности, реисползуемые в разных тестах
 */
@interface MockObjectsFactory : NSObject

/**
 @author Egor Tolstoy
 
 Метод генерирует случайную ошибку
 
 @return NSError
 */
+ (NSError *)generateGeneralError;

/**
 @author Egor Tolstoy
 
 Метод генерирует случайный URL Request
 
 @return NSURLRequest
 */
+ (NSURLRequest *)generateGeneralURLRequest;

/**
 @author Egor Tolstoy
 
 Метод генерирует массив со случайными данными
 
 @return NSArray
 */
+ (NSArray *)generateGeneralArray;
/**
 @author Egor Tolstoy
 
 Метод создает моковую таблицу, которая отдает определенный класс ячейки для идентификатора
 
 @param cellClass  Класс стабовой ячейки
 @param identifier reuseIdentifier ячейки
 
 @return UITableView
 */
+ (UITableView *)mockTableViewWithStubCellClass:(Class)cellClass
                                  forIdentifier:(NSString *)identifier;

+ (UICollectionView *)mockCollectionViewViewWithMockCell:(id)mockCell
                                           forIdentifier:(NSString *)identifier;
/**
 @author Vadim Smal
 
  Метод создает моковую таблицу, которая отдает определенный классы ячейки для идентификаторов
 
 @param cellClasses Массив строк с именем класса
 @param identifiers Массив reuseIdentifier ячеек
 
 @return UITableView
 */
+ (UITableView *)mockTableViewWithStubCellClasses:(NSArray *)cellClasses
                                   forIdentifiers:(NSArray *)identifiers;

+ (NewPostViewModel *)generateNewPostViewModel;

+ (NewPostViewModel *)generateNewPostViewModelWithMediaItems:(NSInteger)count;

@end
