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

#import "SpeakerShortInfoTableViewCell.h"
#import "SpeakerShortInfoTableViewCellObject.h"

#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const kPlaceholderImageName = @"placeholder";

static CGFloat const kSpeakerShortInfoTableViewCellHeight = 173.0f;

@interface SpeakerShortInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *speakerImageView;
@property (weak, nonatomic) IBOutlet UILabel *speakerName;
@property (weak, nonatomic) IBOutlet UILabel *speakerCompanyName;

@end

@implementation SpeakerShortInfoTableViewCell

#pragma mark - NICell methods

- (BOOL)shouldUpdateCellWithObject:(SpeakerShortInfoTableViewCellObject *)object {
    self.speakerName.text = object.speakerName;
    self.speakerCompanyName.text = object.speakerCompanyName;
    [self.speakerImageView sd_setImageWithURL:object.speakerImageLink
                             placeholderImage:[UIImage imageNamed:kPlaceholderImageName]];
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return kSpeakerShortInfoTableViewCellHeight;
}

@end
