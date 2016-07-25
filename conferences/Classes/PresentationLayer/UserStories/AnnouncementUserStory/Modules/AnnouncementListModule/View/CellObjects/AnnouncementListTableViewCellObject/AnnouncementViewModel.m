//
//  EventListTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 25/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "AnnouncementViewModel.h"
#import "EventPlainObject.h"
#import "MetaEventPlainObject.h"

@interface AnnouncementViewModel ()

@property (strong, nonatomic, readwrite) NSString *eventTitle;
@property (strong, nonatomic, readwrite) NSArray *eventTags;
@property (strong, nonatomic, readwrite) NSURL *imageUrl;
@property (strong, nonatomic, readwrite) NSString *date;
@property (strong, nonatomic, readwrite) NSString *time;
@property (strong, nonatomic, readwrite) EventPlainObject *event;

@end

@implementation AnnouncementViewModel

#pragma mark - Initialization

- (instancetype)initWithEvent:(EventPlainObject *)event
                    eventDate:(NSString *)date
                         time:(NSString *)time {
    self = [super init];
    if (self) {
        _date = date;
        _time = time;
        _eventTitle = event.name;
        _eventTags = event.tags.allObjects;
        _imageUrl = [NSURL URLWithString:event.metaEvent.imageUrlPath];
        _event = event;
    }
    return self;
}

+ (instancetype)objectWithEvent:(EventPlainObject *)event
                      eventDate:(NSString *)date
                           time:(NSString *)time {
    return [[self alloc] initWithEvent:event
                             eventDate:date
                                  time:time];
}

@end
