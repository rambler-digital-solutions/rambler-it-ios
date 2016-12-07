//
//  LectureTableViewAnimator.h
//  Conferences
//
//  Created by k.zinovyev on 07.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NICellFactory.h"

@interface LectureTableViewAnimator : NSObject

@property (nonatomic, weak) IBOutlet UITableView *tableView;
    
- (void)updateCellWithIndexPath:(NSIndexPath *)indexPath withCellObject:(id)cellObject;
    
@end
