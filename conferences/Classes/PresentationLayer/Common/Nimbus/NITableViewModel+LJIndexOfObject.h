//
//  NITableViewModel+LJIndexOfObject.h
//  LiveJournal
//
//  Created by Smal Vadim on 10/12/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "NITableViewModel.h"

/**
 @author Vadim Smal
 
 Категория над NITableViewModel для поиска определенного элемента.
 */

@interface NITableViewModel (LJIndexOfObject)

- (NSUInteger)indexOfCellObjectInSection:(NSUInteger)section
                             passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;

@end
