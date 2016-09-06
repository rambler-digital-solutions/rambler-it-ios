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

@class EventPlainObject;
@class TechPlainObject;

@protocol EventInteractorInput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to obtain event plain object with particular object id
 
 @param objectId NSString object id
 
 @return EventPlainObject
 */
- (EventPlainObject *)obtainEventWithObjectId:(NSString *)objectId;

/**
 @author Vasyura Anastasiya
 
 Method is used to obtain past events plain objects with particular object id
 
 @param metaEventId NSString object id
 
 @return NSArray
 */
- (NSArray *)obtainPastEventsForEvent:(EventPlainObject *)event;

/**
 @author Egor Tolstoy
 
 Method tracks current event visit in history
 
 @param event EventPlainObject
 */
- (void)trackEventVisitForEvent:(EventPlainObject *)event;

/**
 @author Artem Karpushin
 
 Method is used to save an event to the calendar
 
 @param event EventPlainObject
 */
- (void)saveEventToCalendar:(EventPlainObject *)event;

/**
 @author Artem Karpushin
 
 Method is used to obtain activity items for UIActivityController
 
 @param event EventPlainObject
 
 @return Activity items
 */
- (NSArray *)obtainActivityItemsForEvent:(EventPlainObject *)event;

@end

