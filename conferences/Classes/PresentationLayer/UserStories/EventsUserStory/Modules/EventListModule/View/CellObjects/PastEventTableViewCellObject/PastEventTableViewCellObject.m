//
//  EventListTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 25/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "PastEventTableViewCellObject.h"
#import "PastEventTableViewCell.h"
#import "PlainEvent.h"

@interface PastEventTableViewCellObject ()

@property (strong, nonatomic, readwrite) NSString *day;
@property (strong, nonatomic, readwrite) NSString *month;
@property (strong, nonatomic, readwrite) NSString *eventTitle;
@property (strong, nonatomic, readwrite) NSString *eventTags;

@end

@implementation PastEventTableViewCellObject

- (instancetype)initWithElementID:(NSInteger)elementID event:(PlainEvent *)event {
    self = [super init];
    if (self) {
        self.elementID = elementID;
        
        // вынести в форматтер
        NSDateFormatter *dayDateFormatter = [NSDateFormatter new];
        [dayDateFormatter setDateFormat:@"dd"];
        NSDateFormatter *monthDateFormatter = [NSDateFormatter new];
        [monthDateFormatter setDateFormat:@"MMMM"];
        
        _day = [dayDateFormatter stringFromDate:event.startDate];
        _month = [monthDateFormatter stringFromDate:event.startDate];
        _eventTitle = event.name;
        _eventTags = event.tags;
    }
    return self;
}

+ (instancetype)objectWithElementID:(NSInteger)elementID event:(PlainEvent *)event {
    return [[self alloc] initWithElementID:elementID event:event];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [PastEventTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([PastEventTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
