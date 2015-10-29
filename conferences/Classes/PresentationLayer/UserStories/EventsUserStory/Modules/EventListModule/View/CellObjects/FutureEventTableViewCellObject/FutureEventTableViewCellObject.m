//
//  FutureEventTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 27/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "FutureEventTableViewCellObject.h"
#import "FutureEventTableViewCell.h"

@implementation FutureEventTableViewCellObject

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [FutureEventTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([FutureEventTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
