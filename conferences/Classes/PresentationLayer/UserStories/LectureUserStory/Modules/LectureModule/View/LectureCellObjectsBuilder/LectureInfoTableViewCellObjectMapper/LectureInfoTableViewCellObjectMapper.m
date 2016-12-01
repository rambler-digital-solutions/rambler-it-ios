//
//  LectureInfoTableViewCellObjectMapper.m
//  Conferences
//
//  Created by k.zinovyev on 01.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "LectureInfoTableViewCellObjectMapper.h"
#import "LectureInfoTableViewCellCalculator.h"
#import "LectureInfoTableViewCellObject.h"
#import "LecturePlainObject.h"

@implementation LectureInfoTableViewCellObjectMapper

- (id<NICellObject>)lectureInfoTableViewCellObjectWithLecture:(LecturePlainObject *)lecture
                                          continueReadingFlag:(BOOL)continueReadingFlag {
    CGFloat heightCell = [self.calculator calculateHeightForLectureInfoCellWithLecture:lecture
                                                                   continueReadingFlag:continueReadingFlag];
    LectureInfoTableViewCellObject *cellObject = [LectureInfoTableViewCellObject objectWithLecture:lecture
                                                                               continueReadingFlag:continueReadingFlag
                                                                                            height:heightCell];
    return cellObject;
}

@end
