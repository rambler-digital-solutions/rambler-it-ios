// Copyright (c) 2015 RAMBLER&Co
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

#import <NICellFactory.h>
#import "CDResponderTableViewCell.h"

@interface LectureInfoTableViewCell : CDResponderTableViewCell <NICell>

@property (nonatomic, weak) IBOutlet UIImageView *speakerImageView;
@property (nonatomic, weak) IBOutlet UILabel *speakerName;
@property (nonatomic, weak) IBOutlet UILabel *speakerCompanyName;
@property (nonatomic, weak) IBOutlet UILabel *lectureDescription;
@property (nonatomic, weak) IBOutlet UILabel *lectureTitle;
@property (nonatomic, weak) IBOutlet UIView *speakerView;
@property (nonatomic, weak) IBOutlet UIButton *continueReadingButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lectureDescriptionTOBottomConstraint;

@end
