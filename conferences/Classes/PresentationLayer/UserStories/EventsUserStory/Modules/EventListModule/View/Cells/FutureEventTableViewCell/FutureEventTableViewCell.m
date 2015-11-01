//
//  FutureEventTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 27/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "FutureEventTableViewCell.h"
#import "FutureEventTableViewCellObject.h"

static NSString *const kPlaceholderImageName = @"placeholder";

@interface FutureEventTableViewCell ()

@property (assign, nonatomic) CGFloat FutureEventTableViewCellHeight;

@end

@implementation FutureEventTableViewCell

- (BOOL)shouldUpdateCellWithObject:(FutureEventTableViewCellObject *)object {
    self.eventTitle.text = object.eventTitle;
    self.day.text = object.day;
    self.month.text = object.month;
    self.imageView.image = object.image;
    
    [self.cellView setBackgroundColor:object.backgroundColor];
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return tableView.frame.size.height - 64;
}

#pragma mark - Private methods

- (void)setPlaceholderForImageIfNeded:(UIImage *)image {
    if (!image) {
        image = [UIImage imageNamed:kPlaceholderImageName];
    }
}

@end
