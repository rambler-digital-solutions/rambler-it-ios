//
//  EventInfoTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 07/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventInfoTableViewCellObject.h"
#import "EventInfoTableViewCell.h"
#import "PlainEvent.h"

@interface EventInfoTableViewCellObject ()

@property (strong, nonatomic, readwrite) NSString *date;
@property (strong, nonatomic, readwrite) NSString *eventTitle;
@property (strong, nonatomic, readwrite) NSString *eventSubTitle;

@end

@implementation EventInfoTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithEvent:(PlainEvent *)event {
    self = [super init];
    if (self) {
        _eventTitle = event.name;
        _eventSubTitle = event.eventSubtitle;
        
        // вынести в форматтер
        NSDateFormatter *dayDateFormatter = [NSDateFormatter new];
        [dayDateFormatter setDateFormat:@"dd MMMM HH:mm"];
        _date = [dayDateFormatter stringFromDate:event.startDate];
    }
    return self;
}

+ (instancetype)objectWithEvent:(PlainEvent *)event {
    return [[self alloc] initWithEvent:event];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [EventInfoTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([EventInfoTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
