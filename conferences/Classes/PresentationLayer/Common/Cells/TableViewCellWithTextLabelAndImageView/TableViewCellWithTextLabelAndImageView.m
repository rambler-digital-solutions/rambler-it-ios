//
//  TableViewCellWithTextLabelAndImageView.m
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "TableViewCellWithTextLabelAndImageView.h"
#import "TableViewCellWithTextLabelAndImageViewCellObject.h"

static CGFloat const TableViewCellWithTextLabelAndImageViewHeight = 40.0f;

@interface TableViewCellWithTextLabelAndImageView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation TableViewCellWithTextLabelAndImageView

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(TableViewCellWithTextLabelAndImageViewCellObject *)object {
    self.iconImageView.image = object.image;
    self.label.text = object.text;
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return TableViewCellWithTextLabelAndImageViewHeight;
}

@end
