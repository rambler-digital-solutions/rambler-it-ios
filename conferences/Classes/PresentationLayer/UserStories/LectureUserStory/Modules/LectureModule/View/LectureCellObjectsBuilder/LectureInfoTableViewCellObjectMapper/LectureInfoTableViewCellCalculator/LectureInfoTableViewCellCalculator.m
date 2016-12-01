//
//  LectureInfoTableViewCellCalculator.m
//  Conferences
//
//  Created by k.zinovyev on 01.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "LectureInfoTableViewCellCalculator.h"
#import "LecturePlainObject.h"
#import "UIFont+RIDTypefaces.h"

static CGFloat const RIDTitleLeftInset = 20.0f;
static CGFloat const RIDTitleRightInset = 20.0f;
static CGFloat const RIDTitleTopInset = 68.0f;
static CGFloat const RIDTitleBottomInset = 8.0f;
static CGFloat const RIDWithContinueReadingInset = 36.0f;
static CGFloat const RIDWithoutContinueReadingInset = 10.0f;

@implementation LectureInfoTableViewCellCalculator

- (CGFloat)calculateHeightForLectureInfoCellWithLecture:(LecturePlainObject *)lecture
                                    continueReadingFlag:(BOOL)continueReadingFlag {
    CGFloat fullHeight = 0;
    NSInteger width = [UIScreen mainScreen].bounds.size.width - RIDTitleLeftInset - RIDTitleRightInset;
    
    CGSize size = CGSizeMake(width, 0);
    NSString *titleText = lecture.name;
    CGFloat heightText = [titleText boundingRectWithSize:size
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{ NSFontAttributeName:[UIFont rid_lectureTitleFont] }
                                                 context:nil].size.height;
    fullHeight += ceil(heightText) + RIDTitleTopInset + RIDTitleBottomInset;
    
    
    NSString *descriptionText = lecture.lectureDescription;
    heightText = [descriptionText boundingRectWithSize:size
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{ NSFontAttributeName:[UIFont rid_lectureDescriptionFont] }
                                               context:nil].size.height;
    CGFloat bottomHeight = continueReadingFlag ? RIDWithContinueReadingInset : RIDWithoutContinueReadingInset;
    fullHeight += ceil(heightText) + bottomHeight;
    return fullHeight;
}


@end
