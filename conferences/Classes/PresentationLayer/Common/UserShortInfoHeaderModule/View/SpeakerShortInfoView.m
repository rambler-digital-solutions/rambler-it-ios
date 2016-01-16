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

#import "SpeakerShortInfoView.h"
#import "SpeakerShortInfoViewOutput.h"
#import "SpeakerPlainObject.h"
#import "SpeakerShortInfoViewSize.h"

#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const kPlaceholderImageName = @"placeholder";

@implementation SpeakerShortInfoView

+ (SpeakerShortInfoView *)speakerShortInfoView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                          owner:self
                                        options:NULL] firstObject];
}

#pragma mark - SpeakerShortInfoViewInput

- (void)configureViewWithDefaultSizeWithSpeaker:(SpeakerPlainObject *)speaker {
    [self setupOutletsWithSpeaker:speaker];
}

- (void)configureViewWithBigSizeWithSpeaker:(SpeakerPlainObject *)speaker {
    [self setupOutletsWithSpeaker:speaker];
    [self setupConstraintsForBigViewSize];
}

#pragma mark - SpeakerShortInfoModuleInput

- (void)configureModuleWithSpeaker:(SpeakerPlainObject *)speaker andViewSize:(SpeakerShortInfoViewSize)viewSize {
    [self.output moduleReadyWithSpeaker:speaker andViewSize:viewSize];
}

#pragma mark - Private methods

- (void)setupOutletsWithSpeaker:(SpeakerPlainObject *)speaker {
    self.nameTextLabel.text = speaker.name;
    self.companyTextLabel.text = speaker.companyName;
    [self.imageView sd_setImageWithURL:speaker.imageUrl
                      placeholderImage:[UIImage imageNamed:kPlaceholderImageName]];
}

- (void)setupConstraintsForBigViewSize {
    
}

@end