//
//  CurrentVideoTranslationTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "CurrentVideoTranslationTableViewCell.h"
#import "CurrentVideoTranslationTableViewCellObject.h"

static CGFloat const kCurrentVideoTranslationTableViewCellHeight = 60.0f;

@implementation CurrentVideoTranslationTableViewCell

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(CurrentVideoTranslationTableViewCellObject *)object {
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return kCurrentVideoTranslationTableViewCellHeight;
}

#pragma mark - IBActions

- (IBAction)didTapCurrentTranslationButton:(UIButton *)sender {
}

@end
