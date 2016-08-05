//
// TagTextFilter.m
// LiveJournal
// 
// Created by Golovko Mikhail on 04/02/16.
// Copyright © 2016 Rambler&Co. All rights reserved.
//

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