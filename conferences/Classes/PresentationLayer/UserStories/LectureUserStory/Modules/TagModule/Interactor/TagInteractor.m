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

#import "TagInteractor.h"

#import "TagService.h"
#import "TagObjectDescriptor.h"
#import "TagModelObject.h"

@implementation TagInteractor

#pragma mark - Методы TagInteractorInput

- (NSArray *)obtainTagsFromObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                    excludeObjectDescriptor:(TagObjectDescriptor *)excludeObjectDescriptor {
    NSArray *tags = [self.tagService obtainTagsFromObjectDescriptor:objectDescriptor
                                            excludeObjectDescriptor:excludeObjectDescriptor];

    return [self plainStringFromObjects:tags];
}

- (void)addTagWithName:(NSString *)tagName
   forObjectDescriptor:(TagObjectDescriptor *)objectDescriptor {
    [self.tagService addTagWithName:tagName
                forObjectDescriptor:objectDescriptor];
}

- (void)removeTagWithName:(NSString *)tagName
      forObjectDescriptor:(TagObjectDescriptor *)objectDescriptor {
    [self.tagService removeTagWithName:tagName
                   forObjectDescriptor:objectDescriptor];
}

#pragma mark - Дополнительные методы

- (NSArray *)plainStringFromObjects:(NSArray *)array {
    NSMutableArray *result = [NSMutableArray array];
    for (TagModelObject *tag in array) {
        [result addObject:tag.name];
    }
    return [result copy];
}


@end