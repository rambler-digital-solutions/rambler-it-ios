//
//  LectureDescriptionTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "LectureDescriptionTableViewCell.h"
#import "LectureDescriptionTableViewCellObject.h"

static CGFloat const kLectureDescriptionTableViewCellHeight = 135.0f;

@interface LectureDescriptionTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation LectureDescriptionTableViewCell

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(LectureDescriptionTableViewCellObject *)object {
    self.dateLabel.text = object.dateString;
    self.titleLabel.text = object.lectureTitle;
    self.descriptionLabel.text = object.lectureDescription;
    
    return YES;
}

- (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return kLectureDescriptionTableViewCellHeight;
}
@end
