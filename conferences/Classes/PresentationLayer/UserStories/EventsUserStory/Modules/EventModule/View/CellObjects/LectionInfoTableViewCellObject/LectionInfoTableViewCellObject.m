//
//  SpeachInfoTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 07/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "LectionInfoTableViewCellObject.h"
#import "LectionInfoTableViewCell.h"

@implementation LectionInfoTableViewCellObject

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [LectionInfoTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([LectionInfoTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
