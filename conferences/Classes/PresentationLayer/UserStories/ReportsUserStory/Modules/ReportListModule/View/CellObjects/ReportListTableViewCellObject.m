//
//  ReportListTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 08/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ReportListTableViewCellObject.h"
#import "ReportListTableViewCell.h"
#import "PlainEvent.h"

@interface ReportListTableViewCellObject ()

@property (strong, nonatomic, readwrite) NSString *date;
@property (strong, nonatomic, readwrite) NSString *eventTitle;
@property (strong, nonatomic, readwrite) UIImage *eventImage;

@end

@implementation ReportListTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithEvent:(PlainEvent *)event {
    self = [super init];
    if (self) {
        _eventTitle = event.name;
        _eventImage = event.image;
        
        // вынести в форматтер
        NSDateFormatter *dayDateFormatter = [NSDateFormatter new];
        [dayDateFormatter setDateFormat:@"dd MMMM"];
        _date = [dayDateFormatter stringFromDate:event.endDate];
    }
    return self;
}

+ (instancetype)objectWithEvent:(PlainEvent *)event {
    return [[self alloc] initWithEvent:event];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [ReportListTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([ReportListTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
