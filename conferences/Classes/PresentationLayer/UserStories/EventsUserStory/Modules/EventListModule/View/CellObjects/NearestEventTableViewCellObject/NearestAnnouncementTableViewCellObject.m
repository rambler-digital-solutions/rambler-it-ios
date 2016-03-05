//
//  FutureEventTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 27/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "NearestAnnouncementTableViewCellObject.h"
#import "NearestAnnouncementTableViewCell.h"
#import "EventPlainObject.h"

@interface NearestAnnouncementTableViewCellObject ()

@property (strong, nonatomic, readwrite) UIImage *image;
@property (strong, nonatomic, readwrite) NSString *date;
@property (strong, nonatomic, readwrite) NSString *time;
@property (strong, nonatomic, readwrite) NSString *eventTitle;
@property (strong, nonatomic, readwrite) UIColor *backgroundColor;
@property (strong, nonatomic, readwrite) NSURL *imageUrl;

@end

@implementation NearestAnnouncementTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithEvent:(EventPlainObject *)event eventDate:(NSString *)date eventStartTime:(NSString *)time {
    self = [super init];
    if (self) {
        _date = date;
        _time = time;
        _eventTitle = event.name;
        _image = event.image;
        _imageUrl = event.imageUrl;
        _backgroundColor = event.backgroundColor;
    }
    return self;
}

+ (instancetype)objectWithEvent:(EventPlainObject *)event eventDate:(NSString *)date eventStartTime:(NSString *)time {
    return [[self alloc] initWithEvent:event eventDate:date eventStartTime:time];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [NearestAnnouncementTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([NearestAnnouncementTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
