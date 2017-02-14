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

@class DirectionCellObjectFactory;
@class DirectionObject;
@protocol RamblerLocationDataDisplayManagerDelegate;

/**
 @author Egor Tolstoy
 
 This object incapsulates the logic of providing data to UICollectionView with directions
 */
@interface RamblerLocationDataDisplayManager : NSObject

@property (nonatomic, strong) DirectionCellObjectFactory *cellObjectFactory;

/**
 @author Egor Tolstoy
 
 Returns a data source object for UICollectionView with directions
 
 @param collectionView UICollectionView with directions
 @param directions     Directions data
 
 @return Data source
 */
- (id<UICollectionViewDataSource>)dataSourceForCollectionView:(UICollectionView *)collectionView
                                               withDirections:(NSArray <DirectionObject *> *)directions;

/**
 @author Egor Tolstoy
 
 Returns a delegate object for UICollectionView with directions
 
 @param collectionView UICollectionView with directions
 
 @return Delegate
 */
- (id<UICollectionViewDelegate>)delegateForCollectionView:(UICollectionView *)collectionView;

/**
 @author Surik Sarkisyan
 
 Method tells dataDisplayManager to set delegate
 
 @param delegate
 */
- (void)setDelegateForDataDisplayManager:(id<RamblerLocationDataDisplayManagerDelegate>)delegate;

@end

@protocol RamblerLocationDataDisplayManagerDelegate <NSObject>

/**
 @author Surik Sarkisyan

 Method tells delegate that scrollView did scroll
 
 @param scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end
