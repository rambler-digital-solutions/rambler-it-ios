//
//  SpeachInfoTableViewCellObject.h
//  Conferences
//
//  Created by Karpushin Artem on 07/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Nimbus/NimbusModels.h>

@class PlainLecture;

@interface LectionInfoTableViewCellObject : NIFormElement <NICellObject>

@property (strong, nonatomic, readonly) NSString *speakerName;
@property (strong, nonatomic, readonly) NSString *speakerCompanyName;
@property (strong, nonatomic, readonly) NSString *lectureDescription;
@property (strong, nonatomic, readonly) NSString *lectureTitle;
@property (strong, nonatomic, readonly) NSURL *speakerImageLink;

+ (instancetype)objectWithLecture:(PlainLecture *)lecture;

@end
