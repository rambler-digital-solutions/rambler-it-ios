//
//  SpeakerInfoSectionHeaderCellObject.m
//  Conferences
//
//  Created by Vasyura Anastasiya on 04/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "SpeakerInfoSectionHeaderCellObject.h"
#import "SpeakerInfoSectionHeaderTableViewCell.h"

@implementation SpeakerInfoSectionHeaderCellObject

- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        _text = text;
    }
    
    return self;
}

+ (instancetype)objectWithText:(NSString *)text {
    return [[self alloc] initWithText:text];
}

# pragma mark - NICellObject methods

- (Class)cellClass {
    return [SpeakerInfoSectionHeaderTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([SpeakerInfoSectionHeaderTableViewCell class])
                          bundle:[NSBundle mainBundle]];
}

@end
