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
#import "MetaEventPlainObject.h"

@interface ReportEventTableViewCellObject ()

@property (nonatomic, strong, readwrite) NSString *date;
@property (nonatomic, strong, readwrite) NSAttributedString *eventTitle;
@property (nonatomic, strong, readwrite) UIImage *eventImage;
@property (nonatomic, strong, readwrite) NSURL *imageURL;
@property (nonatomic, strong, readwrite) NSAttributedString *tags;
@property (nonatomic, strong, readwrite) EventPlainObject *event;

@end

@implementation ReportEventTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithEvent:(EventPlainObject *)event
                      andDate:(NSString *)date
                         tags:(NSAttributedString *)tags
               attributedName:(NSAttributedString *)attributedName{
    self = [super init];
    if (self) {
        _eventTitle = attributedName;
        _imageURL = [NSURL URLWithString:event.metaEvent.imageUrlPath];
        _date = date;
        _tags = tags;
        _event = event;
    }
    return self;
}

+ (instancetype)objectWithEvent:(EventPlainObject *)event
                        andDate:(NSString *)date
                           tags:(NSAttributedString *)tags
                highlightedText:(NSAttributedString *)highlightedText {
    
    return [[self alloc] initWithEvent:event
                               andDate:date
                                  tags:tags
                        attributedName:highlightedText];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [ReportEventTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([ReportEventTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
