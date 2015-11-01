//
//  FutureEventTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 27/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "FutureEventTableViewCellObject.h"
#import "FutureEventTableViewCell.h"
#import "PlainEvent.h"

@interface FutureEventTableViewCellObject ()

@property (strong, nonatomic, readwrite) UIImage *image;
@property (strong, nonatomic, readwrite) NSString *day;
@property (strong, nonatomic, readwrite) NSString *month;
@property (strong, nonatomic, readwrite) NSString *eventTitle;
@property (strong, nonatomic, readwrite) UIColor *backgroundColor;

@end

@implementation FutureEventTableViewCellObject

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
        _image = event.image;
        _backgroundColor = event.backgroundColor;
    }
    return self;
}

+ (instancetype)objectWithElementID:(NSInteger)elementID event:(PlainEvent *)event {
    return [[self alloc] initWithElementID:elementID event:event];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [FutureEventTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([FutureEventTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
