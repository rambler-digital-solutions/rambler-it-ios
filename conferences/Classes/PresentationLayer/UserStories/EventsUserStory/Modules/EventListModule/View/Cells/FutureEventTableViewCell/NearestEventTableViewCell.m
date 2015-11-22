//
//  FutureEventTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 27/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "NearestEventTableViewCell.h"
#import "NearestEventTableViewCellObject.h"

#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const kPlaceholderImageName = @"placeholder";
static CGFloat const kEventListTableViewCellHeight = 64.0f;

@interface NearestEventTableViewCell ()

@property (assign, nonatomic) CGFloat FutureEventTableViewCellHeight;

@end

@implementation NearestEventTableViewCell

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(NearestEventTableViewCellObject *)object {
    self.eventTitle.text = object.eventTitle;
    self.day.text = object.day;
    self.month.text = object.month;
    self.imageView.image = object.image;
    [self.cellView setBackgroundColor:object.backgroundColor];
    
    [self.imageView sd_setImageWithURL:object.imageUrl
                      placeholderImage:[UIImage imageNamed:kPlaceholderImageName]];

    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return tableView.frame.size.height - kEventListTableViewCellHeight;
}

@end
