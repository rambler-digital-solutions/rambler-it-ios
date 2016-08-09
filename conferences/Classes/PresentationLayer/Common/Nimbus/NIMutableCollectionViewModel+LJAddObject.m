//
// NIMutableCollectionViewModel+LJAddObject.m
// LiveJournal
// 
// Created by Golovko Mikhail on 30/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "NIMutableCollectionViewModel+LJAddObject.h"


@implementation NIMutableCollectionViewModel (LJAddObject)

- (NSArray *)addObjectsFromArray:(NSArray *)array toSection:(NSUInteger)section {
    NSMutableArray* indices = [NSMutableArray array];
    for (id object in array) {
        [indices addObject:[[self addObject:object toSection:section] objectAtIndex:0]];
    }
    return indices;
}

@end