//
//  PastVideoTranslationTableViewCell.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "PastVideoTranslationTableViewCell.h"
#import "PastVideoTranslationTableViewCellObject.h"

static CGFloat const kPastVideoTranslationTableViewCellHeight = 100.0f;

@implementation PastVideoTranslationTableViewCell

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(PastVideoTranslationTableViewCellObject *)object {
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return kPastVideoTranslationTableViewCellHeight;
}

@end
