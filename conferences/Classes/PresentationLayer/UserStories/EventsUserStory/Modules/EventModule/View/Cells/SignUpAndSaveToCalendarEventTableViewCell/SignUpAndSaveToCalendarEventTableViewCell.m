//
//  EventInteractionTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "SignUpAndSaveToCalendarEventTableViewCell.h"
#import "SignUpAndSaveToCalendarEventTableViewCellObject.h"

static CGFloat const kSignUpAndSaveToCalendarEventTableViewCellHeight = 120.0f;

@implementation SignUpAndSaveToCalendarEventTableViewCell

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(SignUpAndSaveToCalendarEventTableViewCellObject *)object {
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return kSignUpAndSaveToCalendarEventTableViewCellHeight;
}

#pragma mark - IBActions

- (IBAction)didTapSignUpButton:(UIButton *)sender {
}

- (IBAction)didTapSaveToCalendarButton:(UIButton *)sender {
}

@end
