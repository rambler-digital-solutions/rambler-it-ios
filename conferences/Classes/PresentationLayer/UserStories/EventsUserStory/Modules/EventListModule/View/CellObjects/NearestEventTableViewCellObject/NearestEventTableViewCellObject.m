//
//  FutureEventTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 27/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "NearestEventTableViewCellObject.h"
#import "NearestEventTableViewCell.h"
#import "PlainEvent.h"

@interface NearestEventTableViewCellObject ()

@property (strong, nonatomic, readwrite) UIImage *image;
@property (strong, nonatomic, readwrite) NSString *day;
@property (strong, nonatomic, readwrite) NSString *month;
@property (strong, nonatomic, readwrite) NSString *eventTitle;
@property (strong, nonatomic, readwrite) UIColor *backgroundColor;
@property (strong, nonatomic, readwrite) NSURL *imageUrl;

@end

@implementation NearestEventTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithEvent:(PlainEvent *)event eventDay:(NSString *)day eventMonth:(NSString *)month {
    self = [super init];
    if (self) {
        _day = day;
        _month = month;
        _eventTitle = event.name;
        _image = event.image;
        _imageUrl = event.imageUrl;
        _backgroundColor = event.backgroundColor;
    }
    return self;
}

+ (instancetype)objectWithEvent:(PlainEvent *)event eventDay:(NSString *)day eventMonth:(NSString *)month {
    return [[self alloc] initWithEvent:event eventDay:day eventMonth:month];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [NearestEventTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([NearestEventTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
