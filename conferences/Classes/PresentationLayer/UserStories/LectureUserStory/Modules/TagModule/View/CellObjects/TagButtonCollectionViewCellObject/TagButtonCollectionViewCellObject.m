//
// TagButtonCollectionViewCellObject.m
// LiveJournal
// 
// Created by Golovko Mikhail on 17/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TagButtonCollectionViewCellObject.h"
#import "TagButtonCollectionViewCell.h"


@implementation TagButtonCollectionViewCellObject

- (instancetype)initWithTextButton:(NSString *)textButton type:(TagButtonType)type {
    self = [super init];
    if (self) {
        _textButton = textButton;
        _type = type;
    }

    return self;
}


- (UINib *)collectionViewCellNib {
    NSString *className = NSStringFromClass([TagButtonCollectionViewCell class]);
    NSBundle *bundle = [NSBundle mainBundle];
    UINib *nib = [UINib nibWithNibName:className
                                bundle:bundle];
    return nib;
}

@end