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

#import "EventInteractor.h"

#import "EventInteractorOutput.h"
#import "EventService.h"
#import "EventModelObject.h"
#import "EventPlainObject.h"
#import "ROSPonsomizer.h"
#import "EventTypeDeterminator.h"
#import "EventStoreServiceProtocol.h"
#import "ErrorConstants.h"
#import <MagicalRecord/MagicalRecord.h>
#import "MetaEventModelObject.h"
#import "MetaEventPlainObject.h"
#import "MetaEventService.h"
#import "ShareUrlBuilder.h"
#import "EXTScope.h"

@implementation EventInteractor

#pragma mark - EventListInteractorInput

- (EventPlainObject *)obtainEventWithObjectId:(NSString *)objectId {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", EventModelObjectAttributes.eventId, objectId];
    
    NSArray *events = [self.eventService obtainEventWithPredicate:predicate];
    id managedObjectEvent = [events firstObject];
    
    EventPlainObject *eventPlainObject = [self.ponsomizer convertObject:managedObjectEvent];
    EventType type = [self.eventTypeDeterminator determinateTypeForEvent:eventPlainObject];
    eventPlainObject.eventType = @(type);
    return eventPlainObject;
}

- (NSArray *)obtainPastEventsForEvent:(EventPlainObject *)event {
    NSString *metaEventId = event.metaEvent.metaEventId;
    MetaEventModelObject *metaEvent = [self.metaEventService obtainMetaEventByMetaEventId:metaEventId];
    NSSet *events = [self.ponsomizer convertObject:metaEvent.events];
    NSDate *currentEventDate = event.startDate;
    
    NSMutableArray *pastEvents = [NSMutableArray new];
    for (EventPlainObject *event in events) {
        if ([event.startDate compare:currentEventDate] == NSOrderedAscending) {
            [pastEvents addObject:event];
        }
    }
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:EventModelObjectAttributes.startDate
                                                                 ascending:NO];
    NSArray *sortedEvents = [pastEvents sortedArrayUsingDescriptors:@[descriptor]];
    return sortedEvents;
}

- (void)saveEventToCalendar:(EventPlainObject *)event {
    @weakify(self);
    [self.eventStoreService saveEventToCaledar:event withCompletionBlock:^(NSArray *errors) {
        @strongify(self);
        if (errors.count > 0) {
            for (NSError *error in errors) {
                if (error.code == ErrorEventAlreadyStoredInCalendar) {
                    [self.output didSaveEventToCalendarWithError:error];
                }
            }
        }
        else {
            [self.output didSaveEventToCalendarWithError:nil];
        }
    }];
}

- (NSArray *)filterEventsWithPastEventType:(NSArray *)events {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", EventModelObjectAttributes.eventType, @(PastEvent)];
    NSArray *filteredEvents = [events filteredArrayUsingPredicate:predicate];
    
    return filteredEvents;
}

- (NSArray *)obtainActivityItemsForEvent:(EventPlainObject *)event {
    NSURL *shareUrl = [self.shareUrlBuilder buildShareUrlWithItemId:event.eventId];
    NSArray *activityItems = @[shareUrl];
    return activityItems;
}

@end