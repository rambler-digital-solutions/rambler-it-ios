//
//  LectureInfoTableViewCellCalculator.h
//  Conferences
//
//  Created by k.zinovyev on 01.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LecturePlainObject;

@interface LectureInfoTableViewCellCalculator : NSObject

- (CGFloat)calculateHeightForLectureInfoCellWithLecture:(LecturePlainObject *)lecture
                                    continueReadingFlag:(BOOL)continueReadingFlag;

@end
