//
//  EventListTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 25/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventListTableViewCellObject.h"
#import "EventListTableViewCell.h"
#import "PlainEvent.h"

@interface EventListTableViewCellObject ()

@property (strong, nonatomic, readwrite) NSString *day;
@property (strong, nonatomic, readwrite) NSString *month;
@property (strong, nonatomic, readwrite) NSString *eventTitle;
@property (strong, nonatomic, readwrite) NSString *eventTags;

@end

@implementation EventListTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithEvent:(PlainEvent *)event eventDay:(NSString *)day eventMonth:(NSString *)month {
    self = [super init];
    if (self) {
        _day = day;
        _month = month;
        _eventTitle = event.name;
        _eventTags = event.tags;
    }
    return self;
}

+ (instancetype)objectWithEvent:(PlainEvent *)event eventDay:(NSString *)day eventMonth:(NSString *)month {
    return [[self alloc] initWithEvent:event eventDay:day eventMonth:month];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [EventListTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([EventListTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
