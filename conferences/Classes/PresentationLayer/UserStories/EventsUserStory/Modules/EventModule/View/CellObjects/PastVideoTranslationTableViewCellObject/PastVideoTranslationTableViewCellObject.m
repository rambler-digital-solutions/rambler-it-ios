//
//  PastVideoTranslationTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "PastVideoTranslationTableViewCellObject.h"
#import "PastVideoTranslationTableViewCell.h"

@implementation PastVideoTranslationTableViewCellObject

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [PastVideoTranslationTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([PastVideoTranslationTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
