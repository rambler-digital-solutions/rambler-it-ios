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
@property (strong, nonatomic, readwrite) NSString *eventDescription;

@end

@implementation EventInfoTableViewCellObject

- (instancetype)initWithElementID:(NSInteger)elementID event:(PlainEvent *)event {
    self = [super init];
    if (self) {
        _eventTitle = event.name;
        _eventSubTitle = event.eventSubtitle;
        _eventDescription = event.eventDescription;
        
        // вынести в форматтер
        NSDateFormatter *dayDateFormatter = [NSDateFormatter new];
        [dayDateFormatter setDateFormat:@"dd MMMM HH:mm"];
        _date = [dayDateFormatter stringFromDate:event.startDate];
    }
    return self;
}

+ (instancetype)objectWithElementID:(NSInteger)elementID event:(PlainEvent *)event {
    return [[self alloc] initWithElementID:elementID event:event];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [EventInfoTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([EventInfoTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
