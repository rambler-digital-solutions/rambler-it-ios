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

#import "AnnouncementGalleryPresenter.h"

#import "AnnouncementGalleryViewInput.h"
#import "AnnouncementGalleryInteractorInput.h"
#import "AnnouncementGalleryRouterInput.h"
#import "EventPlainObject.h"

@implementation AnnouncementGalleryPresenter

#pragma mark - Методы AnnouncementGalleryViewOutput

- (void)didTriggerViewReadyEvent {
    [self.view setupInitialState];
    [self.interactor updateEventList];
    
    NSArray *cachedFutureEvents = [self.interactor obtainFutureEventList];
    
    [self updateViewWithEvents:cachedFutureEvents];
}

- (void)didTriggerAnnouncementTapEventWithObject:(EventPlainObject *)event {
    NSString *eventId = event.eventId;
    [self.router openEventModuleWithEventId:eventId];
}

#pragma mark - Методы AnnouncementGalleryInteractorOutput

- (void)didUpdateEventListWithFutureEvents:(NSArray<EventPlainObject *> *)events {
    [self updateViewWithEvents:events];
}

#pragma mark - Private methods

- (void)updateViewWithEvents:(NSArray *)events {
    if (events.count > 0) {
        [self.view updateStateWithFutureEvents:events];
    } else {
        [self.view triggerNoFutureEventsState];
    }
}

@end
