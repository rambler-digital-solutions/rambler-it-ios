//
//  TableViewCellWithTextLabelAndImageViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "LectureMaterialInfoTableViewCellObject.h"
#import "LectureMaterialInfoTableViewCell.h"

@interface LectureMaterialInfoTableViewCellObject ()

@property (strong, nonatomic, readwrite) UIImage *image;
@property (strong, nonatomic, readwrite) NSString *text;

@end

@implementation LectureMaterialInfoTableViewCellObject

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
    return [LectureMaterialInfoTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([LectureMaterialInfoTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
