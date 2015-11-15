//
//  SpeachInfoTableViewCellObject.m
//  Conferences
//
//  Created by Karpushin Artem on 07/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "LectureInfoTableViewCellObject.h"
#import "LectureInfoTableViewCell.h"
#import "PlainLecture.h"
#import "PlainSpeaker.h"

@interface LectureInfoTableViewCellObject ()

@property (strong, nonatomic, readwrite) NSString *speakerName;
@property (strong, nonatomic, readwrite) NSString *speakerCompanyName;
@property (strong, nonatomic, readwrite) NSString *lectureDescription;
@property (strong, nonatomic, readwrite) NSString *lectureTitle;
@property (strong, nonatomic, readwrite) NSURL *speakerImageLink;

@end

@implementation LectureInfoTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithLecture:(PlainLecture *)lecture {
    self = [super init];
    if (self) {
        _lectureDescription = lecture.lectureDescription;
        _lectureTitle = lecture.name;
        
        // TODO: реализовать отображение нескольких докладчиков у одного доклада
        PlainSpeaker *speaker = [lecture.speakers firstObject];
        _speakerName = speaker.name;
        _speakerCompanyName = speaker.companyName;
        _speakerImageLink = speaker.pictureLink;
    }
    return self;
}

+ (instancetype)objectWithLecture:(PlainLecture *)lecture {
    return [[self alloc] initWithLecture:lecture];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [LectureInfoTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([LectureInfoTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
