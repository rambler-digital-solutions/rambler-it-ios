//
//  TableViewCellWithTextLabelAndImageView.m
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "LectureMaterialInfoTableViewCell.h"
#import "LectureMaterialInfoTableViewCellObject.h"

static CGFloat const TableViewCellWithTextLabelAndImageViewHeight = 40.0f;

@interface LectureMaterialInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation LectureMaterialInfoTableViewCell

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(LectureMaterialInfoTableViewCellObject *)object {
    self.iconImageView.image = object.image;
    self.label.text = object.text;
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return TableViewCellWithTextLabelAndImageViewHeight;
}

@end
