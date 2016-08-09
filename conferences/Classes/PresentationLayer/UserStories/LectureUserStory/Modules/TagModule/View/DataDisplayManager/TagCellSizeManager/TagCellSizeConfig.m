//
// TagCellSizeConfig.m
// LiveJournal
// 
// Created by Golovko Mikhail on 30/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TagCellSizeConfig.h"

const CGFloat kLeftContentSpacing = 15;
const CGFloat kRightContentSpacing = 15;
const CGFloat kItemSpacing = 5.0f;

@implementation TagCellSizeConfig

- (instancetype)initWithContentWidth:(CGFloat)contentWidth
                         itemSpacing:(CGFloat)itemSpacing {
    self = [super init];
    if (self) {
        _contentWidth = contentWidth;
        _itemSpacing = itemSpacing;
    }

    return self;
}


+ (instancetype)defaultConfig {

    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGFloat screenWidth = CGRectGetWidth(screenRect);
    CGFloat contentWidth = screenWidth - kLeftContentSpacing - kRightContentSpacing;

    TagCellSizeConfig *config = [[TagCellSizeConfig alloc] initWithContentWidth:contentWidth
                                                                    itemSpacing:kItemSpacing];


    return config;
}


@end