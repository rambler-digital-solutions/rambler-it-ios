//
// TagCellSizeRowCalculator.m
// LiveJournal
// 
// Created by Golovko Mikhail on 30/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TagCellSizeRowCalculator.h"
#import "TagCellSizeConfig.h"

@interface TagCellSizeRowCalculator ()

@property (nonatomic, assign) CGFloat useWidth;
@property (nonatomic, assign, readwrite) NSInteger countRows;
@property (nonatomic, assign, readwrite) NSInteger countAddItems;

@end

@implementation TagCellSizeRowCalculator

- (instancetype)initWithConfig:(TagCellSizeConfig *)config {
    self = [super init];
    if (self) {
        _config = config;
    }

    return self;
}


- (void)addItemAtWidth:(CGFloat)itemWidth {
    if ([self addItemInSameRowAtWidth:itemWidth]) {
        return;
    }
    [self addNewRow];
    [self addItemInSameRowAtWidth:itemWidth];
}

- (BOOL)addItemInSameRowAtWidth:(CGFloat)itemWidth {

    if (self.countRows == 0) {
        return NO;
    }

    CGFloat freeWidth = self.config.contentWidth - self.useWidth;

    CGFloat fullItemWidth = itemWidth;

    if (self.useWidth != 0) {
        fullItemWidth += self.config.itemSpacing;
    }

    if (freeWidth < fullItemWidth) {
        return NO;
    }

    self.useWidth += fullItemWidth;
    self.countAddItems++;

    return YES;
}

- (void)cleanRows {
    self.useWidth = 0;
    self.countRows = 0;
    self.countAddItems = 0;
}

- (void)addNewRow {
    self.useWidth = 0;
    self.countRows++;
}

@end