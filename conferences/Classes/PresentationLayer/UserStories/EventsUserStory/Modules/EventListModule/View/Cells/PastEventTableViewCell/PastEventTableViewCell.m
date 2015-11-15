//
//  EventListTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 25/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "PastEventTableViewCell.h"
#import "PastEventTableViewCellObject.h"

static CGFloat const EventListTableViewCellHeight = 64.0f;

@implementation PastEventTableViewCell

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(PastEventTableViewCellObject *)object {
    self.day.text = object.day;
    self.month.text = object.month;
    self.eventTitle.text = object.eventTitle;
    self.eventTags.text = object.eventTags;
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return EventListTableViewCellHeight;
}

@end
