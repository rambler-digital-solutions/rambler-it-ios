//
//  EventListTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 25/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "FutureEventListTableViewCellObject.h"
#import "FutureEventListTableViewCell.h"
#import "EventPlainObject.h"

@interface FutureEventListTableViewCellObject ()

@property (strong, nonatomic, readwrite) NSString *eventTitle;
@property (strong, nonatomic, readwrite) NSString *eventTags;
@property (strong, nonatomic, readwrite) NSURL *imageUrl;
@property (strong, nonatomic, readwrite) NSString *date;

@end

@implementation FutureEventListTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithEvent:(EventPlainObject *)event eventDate:(NSString *)date {
    self = [super init];
    if (self) {
        _date = date;
        _eventTitle = event.name;
        _eventTags = event.tags;
        _imageUrl = event.imageUrl;
    }
    return self;
}

+ (instancetype)objectWithEvent:(EventPlainObject *)event eventDate:(NSString *)date {
    return [[self alloc] initWithEvent:event eventDate:date];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [FutureEventListTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([FutureEventListTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
