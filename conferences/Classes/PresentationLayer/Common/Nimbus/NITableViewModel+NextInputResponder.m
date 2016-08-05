//
//  NITableViewModel+NextInputResponder.m
//  LiveJournal
//
//  Created by Vasyura Anastasiya on 03/12/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "NITableViewModel+NextInputResponder.h"
#import <NITableViewModel+Private.h>
#import "NextInputResponder.h"

@implementation NITableViewModel (NextInputResponder)

#pragma mark - Публичные методы

- (NSIndexPath *)nextInputResponderIndexPathForIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *resultIndexPath;
    resultIndexPath = [self nextIndexPathForIndexPath:indexPath];
    
    return resultIndexPath;
}

#pragma mark - Приватные методы

- (NSIndexPath *)nextIndexPathForIndexPath:(NSIndexPath *)indexPath {
    NSInteger currentSection = indexPath.section;
    NSInteger currentRow = indexPath.row;
    
    NSArray *sections = self.sections;
    for (NSInteger sectionIndex = currentSection; sectionIndex < sections.count; sectionIndex ++) {
        NSArray *rows = [sections[sectionIndex] rows];
        NSInteger rowIndex = (sectionIndex == currentSection) ? currentRow + 1 : 0;
        for (; rowIndex < rows.count; rowIndex++) {
            
            id <NextInputResponder> nextObject = rows[rowIndex];
            if ([nextObject respondsToSelector:@selector(canBecomeNextInputResponder)]) {
                return [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
            }
        }
    }
    
    return nil;
}

@end
