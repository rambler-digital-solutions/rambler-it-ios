//
//  EventListTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 25/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventListTableViewCell.h"
#import "EventListTableViewCellObject.h"

static CGFloat const EventListTableViewCellHeight = 64.0f;

@implementation EventListTableViewCell

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(EventListTableViewCellObject *)object {
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
