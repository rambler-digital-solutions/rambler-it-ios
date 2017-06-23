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

/**
 @author Egor Tolstoy
 
 Model describes a set of changes. Has transactions for only one objectType.
 */
@interface IndexTransactionBatch : NSObject

/**
 @author Egor Tolstoy
 
 Inserted objects identifiers
 */
@property (nonatomic, strong, readonly) NSOrderedSet *insertIdentifiers;

/**
 @author Egor Tolstoy
 
 Updated objects identifiers
 */
@property (nonatomic, strong, readonly) NSOrderedSet *updateIdentifiers;

/**
 @author Egor Tolstoy
 
 Deleted objects identifiers
 */
@property (nonatomic, strong, readonly) NSOrderedSet *deleteIdentifiers;

/**
 @author Egor Tolstoy
 
 Moved objects identifiers
 */
@property (nonatomic, strong, readonly) NSOrderedSet *moveIdentifiers;

/**
 @author Egor Tolstoy
 
 The single object type of the trasaction batch
 */
@property (nonatomic, strong, readonly) NSString *objectType;

/**
 @author Egor Tolstoy
 
 This method tells if the batch is empty. It checks all the identifiers sets.
 */
@property (nonatomic, assign, readonly, getter=isEmpty) BOOL empty;

+ (instancetype)batchWithObjectType:(NSString *)objectType
                  insertIdentifiers:(NSOrderedSet *)insertIdentifiers
                  updateIdentifiers:(NSOrderedSet *)updateIdentifiers
                  deleteIdentifiers:(NSOrderedSet *)deleteIdentifiers
                    moveIdentifiers:(NSOrderedSet *)moveIdentifiers;

@end
