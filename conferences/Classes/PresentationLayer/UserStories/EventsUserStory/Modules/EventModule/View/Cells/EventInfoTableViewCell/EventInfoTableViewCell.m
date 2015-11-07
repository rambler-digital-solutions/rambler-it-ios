//
//  EventInfoTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 07/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventInfoTableViewCell.h"
#import "EventInfoTableViewCellObject.h"

static CGFloat const EventInfoTableViewCellHeight = 500.0f;

@interface EventInfoTableViewCell ()

 //eventSubTitle ограничить количество символов?

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventSubTitle;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *saveToCalendar;
@property (weak, nonatomic) IBOutlet UITextView *eventDescription;
@property (weak, nonatomic) IBOutlet UIButton *readMoreButton;

@end

@implementation EventInfoTableViewCell

- (BOOL)shouldUpdateCellWithObject:(EventInfoTableViewCellObject *)object {
    return  YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return EventInfoTableViewCellHeight;
}

@end
