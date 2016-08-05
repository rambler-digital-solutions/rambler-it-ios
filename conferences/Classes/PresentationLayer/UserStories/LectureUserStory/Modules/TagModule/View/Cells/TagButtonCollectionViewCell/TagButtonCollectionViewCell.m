//
// TagButtonCollectionViewCell.m
// LiveJournal
// 
// Created by Golovko Mikhail on 17/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TagButtonCollectionViewCell.h"
#import "TagButtonCollectionViewCellObject.h"


@implementation TagButtonCollectionViewCell

#pragma mark - методы NICollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}


- (BOOL)shouldUpdateCellWithObject:(TagButtonCollectionViewCellObject *)object {
    self.textLabel.text = object.textButton;
    return YES;
}

@end