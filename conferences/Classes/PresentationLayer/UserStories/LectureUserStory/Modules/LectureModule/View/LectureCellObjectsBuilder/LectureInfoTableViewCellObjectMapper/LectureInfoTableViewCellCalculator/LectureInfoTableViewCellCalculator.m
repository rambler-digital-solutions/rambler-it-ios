// Copyright (c) 2016 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "LectureInfoTableViewCellCalculator.h"
#import "LectureViewModel.h"
#import "UIFont+RIDTypefaces.h"

static CGFloat const RIDTitleLeftInset = 20.0f;
static CGFloat const RIDTitleRightInset = 20.0f;
static CGFloat const RIDTitleTopInset = 68.0f;
static CGFloat const RIDTitleBottomInset = 8.0f;
static CGFloat const RIDWithContinueReadingInset = 36.0f;
static CGFloat const RIDWithoutContinueReadingInset = 10.0f;

@implementation LectureInfoTableViewCellCalculator

- (CGFloat)calculateHeightForLectureInfoCellWithLecture:(LectureViewModel *)lecture
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
