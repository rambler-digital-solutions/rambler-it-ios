//
//  EventDescriptionTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventDescriptionTableViewCellObject.h"
#import "EventDescriptionTableViewCell.h"
#import "PlainEvent.h"

@implementation EventDescriptionTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithEvent:(PlainEvent *)event {
    self = [super init];
    if (self) {
        _eventDescription = event.eventDescription;
    }
    return self;
}

+ (instancetype)objectWithEvent:(PlainEvent *)event {
    return [[self alloc] initWithEvent:event];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [EventDescriptionTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([EventDescriptionTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
