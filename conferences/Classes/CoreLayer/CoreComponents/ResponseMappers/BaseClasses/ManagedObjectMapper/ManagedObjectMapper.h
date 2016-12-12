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

#import "ResponseMapper.h"

@class ManagedObjectMappingProvider;
@protocol ResponseObjectFormatter;
@protocol EntityNameFormatter;

/**
 @author Egor Tolstoy
 
 It's an object for mapping NSArray of response objects into a specific NSManagedObjects
 */
@interface ManagedObjectMapper : NSObject <ResponseMapper>

@property (nonatomic, strong, readonly) ManagedObjectMappingProvider *provider;
@property (nonatomic, strong, readonly) id<ResponseObjectFormatter> responseFormatter;
@property (nonatomic, strong, readonly) id<EntityNameFormatter> entityNameFormatter;

/**
 @author Egor Tolstoy
 
 The main initializer of ManagedObjectMapper
 
 @param mappingProvider      This provider is used to retrieve a mapping for a given NSManagedObject class name
 @param responseFormatter    This object is used to format the concrete server response in such a way that this mapper can process them (e.g. the formatter can extract an array of objects from a @{results : @[]} dictionary.
 @param entityNameFormatter  This object is used to convert Core Data entity names to classes and backwards.
 
 @return RCFManagedObjectMapper
 */
- (instancetype)initWithMappingProvider:(ManagedObjectMappingProvider *)mappingProvider
                responseObjectFormatter:(id <ResponseObjectFormatter>)responseFormatter
                    entityNameFormatter:(id<EntityNameFormatter>)entityNameFormatter;

@end
