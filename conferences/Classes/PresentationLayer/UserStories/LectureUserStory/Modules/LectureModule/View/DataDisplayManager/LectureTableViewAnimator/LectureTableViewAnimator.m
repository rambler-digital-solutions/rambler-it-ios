//
//  LectureTableViewAnimator.m
//  Conferences
//
//  Created by k.zinovyev on 07.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "LectureTableViewAnimator.h"

@implementation LectureTableViewAnimator

- (void)updateCellWithIndexPath:(NSIndexPath *)indexPath withCellObject:(id)cellObject {
    UITableViewCell<NICell> *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell shouldUpdateCellWithObject:cellObject];
}
    
@end
