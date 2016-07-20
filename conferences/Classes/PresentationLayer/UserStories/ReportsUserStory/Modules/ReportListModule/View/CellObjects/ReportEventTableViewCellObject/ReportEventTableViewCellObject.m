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

#import "ReportEventTableViewCellObject.h"
#import "ReportEventTableViewCell.h"
#import "EventPlainObject.h"
#import "UIColor+ConferencesPallete.h"

@interface ReportEventTableViewCellObject ()

@property (strong, nonatomic, readwrite) NSString *date;
@property (strong, nonatomic, readwrite) NSAttributedString *eventTitle;
@property (strong, nonatomic, readwrite) UIImage *eventImage;
@property (strong, nonatomic, readwrite) NSURL *imageURL;
@property (strong, nonatomic, readwrite) EventPlainObject *event;

@end

@implementation ReportEventTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithEvent:(EventPlainObject *)event andDate:(NSString *)date attributedName:(NSAttributedString *)attributedName{
    self = [super init];
    if (self) {
        _eventTitle = attributedName;
        _eventImage = event.image;
        _imageURL = event.imageUrl;
        _date = date;
        _event = event;
    }
    return self;
}

+ (instancetype)objectWithEvent:(EventPlainObject *)event andDate:(NSString *)date selectedText:(NSString *)selectedText {
    NSMutableAttributedString *attributedName = [[NSMutableAttributedString alloc] initWithString:event.name];
    if ([selectedText length] != 0) {
        NSRange range = [[event.name lowercaseString] rangeOfString:selectedText];
        [attributedName addAttribute:NSForegroundColorAttributeName value:[UIColor colorForSelectedTextEventCellObject] range:range];
    }
    return [[self alloc] initWithEvent:event andDate:date attributedName:attributedName];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [ReportEventTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([ReportEventTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
