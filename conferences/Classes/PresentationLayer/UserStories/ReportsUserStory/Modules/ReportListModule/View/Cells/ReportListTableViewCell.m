//
//  ReportListTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 08/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ReportListTableViewCell.h"
#import "ReportListTableViewCellObject.h"

static CGFloat const kReportListTableViewCellHeight = 96.0f;

@interface ReportListTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;

@end

@implementation ReportListTableViewCell

- (BOOL)shouldUpdateCellWithObject:(ReportListTableViewCellObject *)object {
    self.date.text = object.date;
    self.eventTitle.text = object.eventTitle;
    self.eventImageView.image = [UIImage imageNamed:@"placeholder"];
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return kReportListTableViewCellHeight;
}

@end
