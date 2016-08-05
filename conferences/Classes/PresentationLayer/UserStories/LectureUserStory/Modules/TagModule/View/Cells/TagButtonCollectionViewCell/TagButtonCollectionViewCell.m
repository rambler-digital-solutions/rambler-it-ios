//
// TagButtonCollectionViewCell.m
// LiveJournal
// 
// Created by Golovko Mikhail on 17/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TagButtonCollectionViewCell.h"
#import "TagButtonCollectionViewCellObject.h"
#import "UIColor+LJPalette.h"


@implementation TagButtonCollectionViewCell

#pragma mark - методы NICollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [UIColor lj_lightGrayColor].CGColor;
}


- (BOOL)shouldUpdateCellWithObject:(TagButtonCollectionViewCellObject *)object {
    self.textLabel.text = object.textButton;
    return YES;
}

@end