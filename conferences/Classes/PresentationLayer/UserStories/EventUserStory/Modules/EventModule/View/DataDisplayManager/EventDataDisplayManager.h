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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DataDisplayManager.h"

@class EventPlainObject;
@class EventCellObjectBuilderFactory;
@class EventViewAnimator;
@class TechPlainObject;

@protocol EventDataDisplayManagerDelegate <NSObject>

/**
 @author Egor Tolstoy
 
 The method tells a delegate that a lecture cell was tapped
 
 @param lectureObjectId lecture identifier
 */
- (void)didTapLectureInfoCellWithLectureObjectId:(NSString *)lectureObjectId;

/**
 @author Egor Tolstoy
 
 The method tells a delegate that an event cell was tapped
 
 @param eventId Event identifier
 */
- (void)didTapEventCellWithEventId:(NSString *)eventId;

@end

@interface EventDataDisplayManager : NSObject <DataDisplayManager>

@property (nonatomic, strong) EventCellObjectBuilderFactory *cellObjectBuilderFactory;
@property (nonatomic, weak) id <EventDataDisplayManagerDelegate> delegate;
@property (nonatomic, strong) EventViewAnimator *eventViewAnimator;

- (void)configureDataDisplayManagerWithEvent:(EventPlainObject *)event
                                  pastEvents:(NSArray *)pastEvents;

@end


