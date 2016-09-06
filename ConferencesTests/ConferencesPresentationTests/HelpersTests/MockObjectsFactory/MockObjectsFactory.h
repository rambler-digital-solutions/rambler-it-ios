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
