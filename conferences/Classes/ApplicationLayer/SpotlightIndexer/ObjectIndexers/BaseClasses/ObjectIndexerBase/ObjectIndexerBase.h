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

#import "ObjectIndexer.h"

@class CSSearchableIndex;
@class CSSearchableItem;
@protocol IndexIdentifierFormatter;

/**
 @autor Egor Tolstoy
 
 Base indexer class with some abstract methods that needs to be overriden
 */
@interface ObjectIndexerBase : NSObject <ObjectIndexer>

- (instancetype)initWithIndexIdentifierFormatter:(id<IndexIdentifierFormatter>)indexIdentifierFormatter
                                 searchableIndex:(CSSearchableIndex *)searchableIndex;

/**
 @author Egor Tolstoy
 
 This method should return an object using the provided identifier. If this method returns nil, changed object won't be indexed.
 This method should be overridden in your custom subclass.
 
 @param identifier Changed object identifier
 
 @return An object for indexing
 */
- (id)objectForIdentifier:(NSString *)identifier;

/**
 @author Egor Tolstoy
 
 This method should return a CSSearchableItem for a certain object.
 
 @param object An object for indexing
 
 @return CSSearchableItem
 */
- (CSSearchableItem *)searchableItemForObject:(id)object;

@end
