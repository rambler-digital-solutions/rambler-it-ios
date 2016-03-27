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

#import "EventStoreService.h"
#import "EventStoreServiceProtocol.h"
#import "EventPlainObject.h"
#import <EventKit/EventKit.h>
#import "ErrorConstants.h"

@implementation EventStoreService

- (void)saveEventToCaledar:(EventPlainObject *)event withCompletionBlock:(EventStoreCompletionBlock)completionBlock{
    NSMutableArray *errors = [@[] mutableCopy];
    
    if (![self needToSaveEvent:event]) {
        NSError *eventAlredyStoredError = [NSError errorWithDomain:ErrorDomain code:ErrorEventAlreadyStoredInCalendar userInfo:nil];
        [errors addObject:eventAlredyStoredError];
        
        completionBlock(errors);
        return;
    }
    
    EKEventStore *eventStore = [EKEventStore new];
    
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            return;
        }
        
        if (error) {
            [errors addObject:error];
        }
        
        EKEvent *calendarEvent = [EKEvent eventWithEventStore:eventStore];
        calendarEvent.title = event.name;
        calendarEvent.startDate = event.startDate;
        calendarEvent.endDate = event.endDate;
        calendarEvent.calendar = [eventStore defaultCalendarForNewEvents];
        
        NSError *savingEventError;
        
        [eventStore saveEvent:calendarEvent span:EKSpanThisEvent commit:YES error:&savingEventError];
        
        if (savingEventError) {
            [errors addObject:savingEventError];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(errors);
        });
    }];
}

#pragma mark - Private methods

- (BOOL)needToSaveEvent:(EventPlainObject *)event {
    EKEventStore *eventStore = [EKEventStore new];
    
    NSPredicate *eventPredicate = [eventStore predicateForEventsWithStartDate:event.startDate endDate:event.endDate calendars:nil];
    
    NSArray *events = [eventStore eventsMatchingPredicate:eventPredicate];
    
    BOOL needToSaveEvent = YES;
    
    for (EKEvent *calendarEvent in events) {
        if ([calendarEvent.title isEqualToString:event.name]) {
            needToSaveEvent = NO;
        }
    }
    return  needToSaveEvent;
}

@end
