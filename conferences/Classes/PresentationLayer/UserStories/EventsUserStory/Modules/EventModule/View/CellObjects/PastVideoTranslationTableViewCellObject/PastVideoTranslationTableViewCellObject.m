//
//  PastVideoTranslationTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "PastVideoTranslationTableViewCellObject.h"
#import "PastVideoTranslationTableViewCell.h"
#import "PlainEvent.h"

@implementation PastVideoTranslationTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithEvent:(PlainEvent *)event {
    self = [super init];
    if (self) {
        // 
    }
    return self;
}

+ (instancetype)objectWithEvent:(PlainEvent *)event {
    return [[self alloc] initWithEvent:event];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [PastVideoTranslationTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([PastVideoTranslationTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
