//
//  EventDescriptionTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventDescriptionTableViewCell.h"
#import "EventDescriptionTableViewCellObject.h"

static CGFloat const kEventDescriptionTableViewCellHeight = 190.0f;

@interface EventDescriptionTableViewCell ()

@property (weak, nonatomic) IBOutlet UITextView *eventDescription;

@end

@implementation EventDescriptionTableViewCell

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(EventDescriptionTableViewCellObject *)object {
    self.eventDescription.text = object.eventDescription;
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return kEventDescriptionTableViewCellHeight;
}

#pragma mark - IBActions

- (IBAction)didTapReadMoreButton:(UIButton *)sender {
}

@end
