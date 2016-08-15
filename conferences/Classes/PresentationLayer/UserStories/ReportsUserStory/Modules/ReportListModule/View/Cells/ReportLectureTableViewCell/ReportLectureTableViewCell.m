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

#import "ReportLectureTableViewCell.h"
#import "ReportLectureTableViewCellObject.h"
#import <SDWebImage/UIImageView+WebCache.h>

static CGFloat const kReportLectureTableViewSeparatorInset = 20.0f;

@interface ReportLectureTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *lectureTitle;
@property (nonatomic, weak) IBOutlet UILabel *speakerName;
@property (nonatomic, weak) IBOutlet UILabel *tags;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (nonatomic, weak) IBOutlet UIImageView *lectureImageView;

@end

@implementation ReportLectureTableViewCell

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(ReportLectureTableViewCellObject *)object {
    self.lectureTitle.attributedText = object.lectureTitle;
    self.companyLabel.text = object.company;
    self.lectureImageView.layer.cornerRadius = self.lectureImageView.frame.size.height/2.0;
    [self.lectureImageView sd_setImageWithURL:object.imageURL
                             placeholderImage:nil];
    self.speakerName.text = object.speakerName;
    self.tags.attributedText = object.tags;
    self.separatorInset = UIEdgeInsetsMake(0.f, kReportLectureTableViewSeparatorInset, 0.f, 0.0f);
    return YES;
}

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
    return UITableViewAutomaticDimension;
}

@end
