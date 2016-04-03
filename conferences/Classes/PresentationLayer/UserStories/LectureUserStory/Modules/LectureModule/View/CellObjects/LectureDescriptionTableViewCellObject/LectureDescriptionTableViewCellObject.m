//
//  LectureDescriptionTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "LectureDescriptionTableViewCellObject.h"
#import "LectureDescriptionTableViewCell.h"
#import "LecturePlainObject.h"

@interface LectureDescriptionTableViewCellObject ()

@property (strong, nonatomic, readwrite) NSString *dateString;
@property (strong, nonatomic, readwrite) NSString *lectureTitle;
@property (strong, nonatomic, readwrite) NSString *lectureDescription;

@end

@implementation LectureDescriptionTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithLecture:(LecturePlainObject *)lecture andDate:(NSString *)date {
    self = [super init];
    if (self) {
        _dateString = date;
        _lectureDescription = lecture.lectureDescription;
        _lectureTitle = lecture.name;
    }
    return self;
}

+ (instancetype)objectWithLecture:(LecturePlainObject *)lecture andDate:(NSString *)date {
    return [[self alloc] initWithLecture:lecture andDate:date];
}

# pragma mark - NICellObject methods

- (Class)cellClass {
    return [LectureDescriptionTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([LectureDescriptionTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
