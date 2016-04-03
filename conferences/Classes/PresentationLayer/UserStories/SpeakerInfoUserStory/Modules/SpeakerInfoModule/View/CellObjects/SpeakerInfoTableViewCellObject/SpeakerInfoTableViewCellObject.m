//
//  SpeakerInfoTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 20/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "SpeakerInfoTableViewCellObject.h"
#import "SpeakerInfoTableViewCell.h"

@interface SpeakerInfoTableViewCellObject ()

@property (strong, nonatomic, readwrite) NSString *text;

@end

@implementation SpeakerInfoTableViewCellObject

#pragma mark - Initialization

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
    return [SpeakerInfoTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([SpeakerInfoTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
