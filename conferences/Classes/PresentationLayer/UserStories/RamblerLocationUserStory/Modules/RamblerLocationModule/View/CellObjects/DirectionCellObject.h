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

#import <Nimbus/NimbusCollections.h>

@class DirectionObject;

/**
 @author Egor Tolstoy
 
 CellObject for UICollectionView with directions to Rambler&Co HQ
 */
@interface DirectionCellObject : NSObject <NICollectionViewCellObject>

/**
 @author Egor Tolstoy
 
 Basic constructor for cell object, which uses a DirectionObject to populate it with data
 
 @param direction DirectionObject model
 
 @return DirectionCellObject
 */
+ (instancetype)objectWithDirection:(DirectionObject *)direction;

/**
 @author Egor Tolstoy
 
 The direction title
 */
@property (nonatomic, copy, readonly) NSString *directionTitle;

/**
 @author Egor Tolstoy
 
 The direction description
 */
@property (nonatomic, copy, readonly) NSString *directionDescription;

@end
