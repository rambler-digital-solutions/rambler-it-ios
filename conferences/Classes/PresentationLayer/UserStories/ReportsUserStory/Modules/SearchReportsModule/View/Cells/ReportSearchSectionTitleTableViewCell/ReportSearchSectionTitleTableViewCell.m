//
//  ReportSearchSectionTitleTableViewCell.m
//  Conferences
//
//  Created by k.zinovyev on 15.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ReportSearchSectionTitleTableViewCell.h"
#import "ReportSearchSectionTitleCellObject.h"

static CGFloat const kTableViewCellHeight = 47.0f;

@implementation ReportSearchSectionTitleTableViewCell

- (BOOL)shouldUpdateCellWithObject:(ReportSearchSectionTitleCellObject *)object {
    
    self.sectionTitle.text = object.sectionTitle;
    self.backgroundColor = object.backgroundColorSection;
    self.separatorInset = UIEdgeInsetsMake(0.f, self.bounds.size.width, 0.f, 0.0f);
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
    return kTableViewCellHeight;
}

@end
