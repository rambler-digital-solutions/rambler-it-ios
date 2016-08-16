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

#import "EventGalleryEventCollectionViewCellObject.h"

#import "EventGalleryEventCollectionViewCell.h"
#import "EventPlainObject.h"
#import "MetaEventPlainObject.h"

@interface EventGalleryEventCollectionViewCellObject ()

@property (nonatomic, strong, readwrite) EventPlainObject *event;
@property (nonatomic, strong, readwrite) NSString *eventTitle;
@property (nonatomic, strong, readwrite) UIColor *primaryColor;
@property (nonatomic, strong, readwrite) NSString *eventDescription;
@property (nonatomic, strong, readwrite) NSString *eventDate;
@property (nonatomic, strong, readwrite) NSString *eventTime;
@property (nonatomic, strong, readwrite) NSString *eventImageUrl;

@end

@implementation EventGalleryEventCollectionViewCellObject

#pragma mark - Initialization

- (instancetype)initWithEvent:(EventPlainObject *)event
                 primaryColor:(UIColor *)primaryColor
                    eventDate:(NSString *)eventDate
                    eventTime:(NSString *)eventTime {
    self = [super init];
    if (self) {
        _event = event;
        _primaryColor = primaryColor;
        
        _eventTitle = event.name;
        _eventDescription = event.metaEvent.metaEventDescription;
        _eventImageUrl = event.metaEvent.imageUrlPath;
        _eventDate = eventDate;
        _eventTime = eventTime;
    }
    return self;
}

+ (instancetype)objectWithEvent:(EventPlainObject *)event
                   primaryColor:(UIColor *)primaryColor
                      eventDate:(NSString *)eventDate
                      eventTime:(NSString *)eventTime {
    return [[self alloc] initWithEvent:event
                          primaryColor:primaryColor
                             eventDate:eventDate
                             eventTime:eventTime];
}

#pragma mark - <NICollectionViewNibCellObject>

- (UINib *)collectionViewCellNib {
    return [UINib nibWithNibName:NSStringFromClass([EventGalleryEventCollectionViewCell class])
                          bundle:nil];
}

- (Class)collectionViewCellClass {
    return [EventGalleryEventCollectionViewCell class];
}

@end
