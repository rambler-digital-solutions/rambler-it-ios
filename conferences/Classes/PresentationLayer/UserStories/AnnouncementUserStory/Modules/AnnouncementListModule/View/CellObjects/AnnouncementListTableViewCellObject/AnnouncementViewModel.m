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

#import "AnnouncementViewModel.h"
#import "EventPlainObject.h"
#import "MetaEventPlainObject.h"

@interface AnnouncementViewModel ()

@property (strong, nonatomic, readwrite) NSString *eventTitle;
@property (strong, nonatomic, readwrite) NSArray *eventTags;
@property (strong, nonatomic, readwrite) NSURL *imageUrl;
@property (strong, nonatomic, readwrite) NSString *date;
@property (strong, nonatomic, readwrite) NSString *time;
@property (strong, nonatomic, readwrite) EventPlainObject *event;

@end

@implementation AnnouncementViewModel

#pragma mark - Initialization

- (instancetype)initWithEvent:(EventPlainObject *)event
                    eventDate:(NSString *)date
                         time:(NSString *)time {
    self = [super init];
    if (self) {
        _date = date;
        _time = time;
        _eventTitle = event.name;
        _eventTags = event.tags.allObjects;
        _imageUrl = [NSURL URLWithString:event.metaEvent.imageUrlPath];
        _event = event;
    }
    return self;
}

+ (instancetype)objectWithEvent:(EventPlainObject *)event
                      eventDate:(NSString *)date
                           time:(NSString *)time {
    return [[self alloc] initWithEvent:event
                             eventDate:date
                                  time:time];
}

@end
