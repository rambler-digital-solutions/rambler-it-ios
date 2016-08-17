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

#import "TagTextFilter.h"

@interface TagTextFilter ()

@property (nonatomic, copy) NSArray *allTags;

@property (nonatomic, strong) NSArray *previousFilterTags;
@property (nonatomic, strong) NSString *previousFilterName;

@end

@implementation TagTextFilter

- (void)setupTagsForFiltering:(NSArray *)tags {
    self.allTags = tags;
    self.previousFilterName = nil;
    self.previousFilterTags = tags;
}

- (NSArray *)obtainTagsFilteredByName:(NSString *)name {
    // Если передали пустышку, не фильтруем.
    if (name == nil
            || name.length == 0) {
        return self.allTags;
    }

    // Если фильтр не поменялся, возвращаем предыдущий результат.
    if ([self.previousFilterName isEqual:name]) {
        return self.previousFilterTags;
    }

    NSArray *tagForFilter = self.allTags;

    if (name.length > self.previousFilterName.length) {
        // Если в новой строке добавились символы, то будем фильтровать предыдущий результат.
        NSString *nameSubstring = [name substringToIndex:self.previousFilterName.length];
        if ([nameSubstring isEqualToString:self.previousFilterName]) {
            tagForFilter = self.previousFilterTags;
        }
    }

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self BEGINSWITH[c] %@",
                                                              name];

    NSArray *filteredTags = [tagForFilter filteredArrayUsingPredicate:predicate];

    self.previousFilterName = name;
    self.previousFilterTags = filteredTags;

    return self.previousFilterTags;
}


@end