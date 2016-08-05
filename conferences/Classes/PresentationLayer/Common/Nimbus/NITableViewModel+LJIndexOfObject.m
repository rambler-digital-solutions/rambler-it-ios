//
//  NITableViewModel+LJIndexOfObject.m
//  LiveJournal
//
//  Created by Smal Vadim on 10/12/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "NITableViewModel+LJIndexOfObject.h"
#import "NITableViewModel+Private.h"

@implementation NITableViewModel (LJIndexOfObject)

- (NSUInteger)indexOfCellObjectInSection:(NSUInteger)sectionIndex
                             passingTest:(BOOL (^)(id, NSUInteger, BOOL *))predicate {
    NITableViewModelSection *section = [self.sections objectAtIndex:sectionIndex];
    if (!section) {
        return [section.rows indexOfObjectPassingTest:predicate];
    }
    return 0;
}

@end
