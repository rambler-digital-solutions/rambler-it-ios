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
 
 Object generates various mock entities, reusable in different tests
 */
@interface MockObjectsFactory : NSObject

/**
 @author Egor Tolstoy
 
 Method generates random error
 
 @return NSError
 */
+ (NSError *)generateGeneralError;

/**
 @author Egor Tolstoy
 
 Method generates random URL Request
 
 @return NSURLRequest
 */
+ (NSURLRequest *)generateGeneralURLRequest;

/**
 @author Egor Tolstoy
 
 Method generates array with random data
 
 @return NSArray
 */
+ (NSArray *)generateGeneralArray;
/**
 @author Egor Tolstoy
 
 Method generates mock table, that return concrete class cell for concrete identifier
 
 @param cellClass  Class for cell
 @param identifier reuseIdentifier ячейки
 
 @return UITableView
 */
+ (UITableView *)mockTableViewWithStubCellClass:(Class)cellClass
                                  forIdentifier:(NSString *)identifier;

+ (UICollectionView *)mockCollectionViewViewWithMockCell:(id)mockCell
                                           forIdentifier:(NSString *)identifier;
/**
 @author Vadim Smal
 
 Method generates mock table, that return concrete classes cells for concrete identifiers
 
 @param cellClasses Array with classes names
 @param identifiers Array wuth reuseIdentifier cells
 
 @return UITableView
 */
+ (UITableView *)mockTableViewWithStubCellClasses:(NSArray *)cellClasses
                                   forIdentifiers:(NSArray *)identifiers;

+ (NewPostViewModel *)generateNewPostViewModel;

+ (NewPostViewModel *)generateNewPostViewModelWithMediaItems:(NSInteger)count;

@end
