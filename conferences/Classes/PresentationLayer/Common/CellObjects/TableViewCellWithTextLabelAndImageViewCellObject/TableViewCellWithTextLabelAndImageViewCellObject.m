//
//  TableViewCellWithTextLabelAndImageViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "TableViewCellWithTextLabelAndImageViewCellObject.h"
#import "TableViewCellWithTextLabelAndImageView.h"

@interface TableViewCellWithTextLabelAndImageViewCellObject ()

@property (strong, nonatomic, readwrite) UIImage *image;
@property (strong, nonatomic, readwrite) NSString *text;

@end

@implementation TableViewCellWithTextLabelAndImageViewCellObject

#pragma mark - Initialization

- (instancetype)initWithText:(NSString *)text andImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _text = text;
        _image = image;
    }
    return self;
}

+ (instancetype)objectWithText:(NSString *)text andImage:(UIImage *)image {
    return [[self alloc] initWithText:text andImage: image];
}

# pragma mark - NICellObject methods

- (Class)cellClass {
    return [TableViewCellWithTextLabelAndImageView class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([TableViewCellWithTextLabelAndImageView class]) bundle:[NSBundle mainBundle]];
}

@end
