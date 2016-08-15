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

#import "ResponseConverterImplementation.h"

static NSString *const kEventAttributesKey = @"attributes";
static NSString *const kEventDeletedKey = @"deleted";
static NSString *const kEventUpdatedKey = @"updated";
static NSString *const kServerResponseResultsKey = @"data";

@implementation ResponseConverterImplementation

- (NSDictionary *)convertFromResponse:(NSDictionary *)dict {
    NSArray *data = [self.responseFormatter formatServerResponse:dict];
    
    NSMutableArray *deletedObjects = [NSMutableArray new];
    NSMutableArray *updatedObjects = [NSMutableArray new];
    for (NSDictionary *dict in data) {
        if (dict[kEventAttributesKey][kEventDeletedKey]) {
            [deletedObjects addObject:dict];
        }
        else {
            [updatedObjects addObject:dict];
        }
    }
    NSDictionary *resultDict = @{
                                 kEventDeletedKey : deletedObjects,
                                 kEventUpdatedKey : updatedObjects
                                 };
    
    return resultDict;
}

@end
