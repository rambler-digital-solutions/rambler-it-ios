//
//  FutureEventTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 27/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "FutureEventTableViewCell.h"
#import "FutureEventTableViewCellObject.h"

@implementation FutureEventTableViewCell

- (BOOL)shouldUpdateCellWithObject:(FutureEventTableViewCellObject *)object {
    
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return 550;
}

@end
