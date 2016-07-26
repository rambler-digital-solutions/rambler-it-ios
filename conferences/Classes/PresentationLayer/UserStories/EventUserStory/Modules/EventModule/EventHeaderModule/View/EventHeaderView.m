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

#import "EventHeaderView.h"
#import "EventHeaderViewOutput.h"
#import "EventPlainObject.h"
#import "EventHeaderModuleInput.h"
#import "MetaEventPlainObject.h"
#import "TechPlainObject.h"
#import "UIColor+Hex.h"

#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const kPlaceholderImageName = @"placeholder";

@implementation EventHeaderView

+ (EventHeaderView *)eventHeaderView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                          owner:self
                                        options:NULL] firstObject];
}

#pragma mark - EventHeaderViewInput

- (void)configureViewWithEvent:(EventPlainObject *)event {
    self.backgroundView.backgroundColor = [UIColor colorFromHexString:event.tech.color];
    [self.eventImageView sd_setImageWithURL:[NSURL URLWithString:event.metaEvent.imageUrlPath]
                           placeholderImage:[UIImage imageNamed:kPlaceholderImageName]];
}

#pragma mark - EventHeaderModuleInput

- (void)configureModuleWithEvent:(EventPlainObject *)event {
    [self.output moduleReadyWithEvent:event];
}

@end