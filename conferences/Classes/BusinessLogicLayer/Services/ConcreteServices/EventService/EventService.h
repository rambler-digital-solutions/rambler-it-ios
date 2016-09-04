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

@class NSPredicate;

typedef void (^EventsCompletionBlock)(NSError *error);

/**
 @author Artem Karpushin
 
 The service is designed to obtain / update Event objects
 */
@protocol EventService <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to obtain Event object from cache
 
 @param predicate NSPredicate for specifying the filtering parameters
 
 @return Event object
 */
- (NSArray *)obtainEventsWithPredicate:(NSPredicate *)predicate;

/**
 @author Egor Tolstoy
 
 Method is used to update a list of Event objects by sending request to server
 
 @param completionBlock Block called upon completion the method, and returns NSError if there is any
 */
- (void)updateEventListWithCompletionBlock:(EventsCompletionBlock)completionBlock;

/**
 @author Konstantin Zinovyev
 
 Method is used to configure EventList object
 */
- (void)setupPredefinedEventListIfNeeded;

/**
 @author Egor Tolstoy
 
 Method tracks event visit in history
 
 @param eventId Event identifier
 */
- (void)trackEventVisitForEventId:(NSString *)eventId;

@end
