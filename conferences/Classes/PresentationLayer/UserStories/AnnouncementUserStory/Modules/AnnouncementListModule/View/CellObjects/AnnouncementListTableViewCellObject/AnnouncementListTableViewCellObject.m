//
//  EventListTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 25/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "AnnouncementListTableViewCellObject.h"
#import "AnnouncementListTableViewCell.h"
#import "EventPlainObject.h"
#import "MetaEventPlainObject.h"

@interface AnnouncementListTableViewCellObject ()

@property (strong, nonatomic, readwrite) NSString *eventTitle;
@property (strong, nonatomic, readwrite) NSArray *eventTags;
@property (strong, nonatomic, readwrite) NSURL *imageUrl;
@property (strong, nonatomic, readwrite) NSString *date;
@property (strong, nonatomic, readwrite) EventPlainObject *event;

@end

@implementation AnnouncementListTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithEvent:(EventPlainObject *)event eventDate:(NSString *)date {
    self = [super init];
    if (self) {
        _date = date;
        _eventTitle = event.name;
        _eventTags = event.tags.allObjects;
        _imageUrl = [NSURL URLWithString:event.metaEvent.imageUrlPath];
        _event = event;
    }
    return self;
}

+ (instancetype)objectWithEvent:(EventPlainObject *)event eventDate:(NSString *)date {
    return [[self alloc] initWithEvent:event eventDate:date];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [AnnouncementListTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([AnnouncementListTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
