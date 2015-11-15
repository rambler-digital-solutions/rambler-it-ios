//
//  CurrentVideoTranslationTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "CurrentVideoTranslationTableViewCellObject.h"
#import "CurrentVideoTranslationTableViewCell.h"

@interface CurrentVideoTranslationTableViewCellObject ()

@property (strong, nonatomic, readwrite) UIColor *buttonColol;

@end

@implementation CurrentVideoTranslationTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithElementID:(NSInteger)elementID event:(PlainEvent *)event {
    self = [super init];
    if (self) {
        self.elementID = elementID;
        // set button color
    }
    return self;
}

+ (instancetype)objectWithElementID:(NSInteger)elementID event:(PlainEvent *)event {
    return [[self alloc] initWithElementID:elementID event:event];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [CurrentVideoTranslationTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([CurrentVideoTranslationTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
