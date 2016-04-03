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

#import "NearestAnnouncementTableViewCell.h"
#import "NearestAnnouncementTableViewCellObject.h"

#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const kPlaceholderImageName = @"placeholder";
static CGFloat const ValueToCutForShortcutDisplayMode = 114.0f;

@interface NearestAnnouncementTableViewCell ()

@property (assign, nonatomic) CGFloat FutureEventTableViewCellHeight;

@end

@implementation NearestAnnouncementTableViewCell

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(NearestAnnouncementTableViewCellObject *)object {
    self.eventTitle.text = object.eventTitle;
    self.date.text = object.date;
    self.time.text = object.time;
    self.imageView.image = object.image;
    [self.cellView setBackgroundColor:object.backgroundColor];
    
    [self.imageView sd_setImageWithURL:object.imageUrl
                      placeholderImage:[UIImage imageNamed:kPlaceholderImageName]];

    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    NearestAnnouncementTableViewCellDisplayMode displayMode = ((NearestAnnouncementTableViewCellObject *)object).displayMode;
        
    if (displayMode == NearestAnnouncementTableViewCellDisplayModeDefault) {
        return tableView.frame.size.height;
    }
    else {
        return tableView.frame.size.height - ValueToCutForShortcutDisplayMode;
    }
}

@end
