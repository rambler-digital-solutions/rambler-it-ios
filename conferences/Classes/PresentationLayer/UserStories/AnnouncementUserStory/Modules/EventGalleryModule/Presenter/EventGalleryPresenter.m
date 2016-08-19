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

#import "EventGalleryPresenter.h"

#import "EventGalleryViewInput.h"
#import "EventGalleryInteractorInput.h"
#import "EventGalleryRouterInput.h"
#import "EventPlainObject.h"

@implementation EventGalleryPresenter

#pragma mark - Методы EventGalleryViewOutput

- (void)didTriggerViewReadyEvent {
    [self.view setupInitialState];
    [self.interactor updateEventList];

    NSArray *cachedFutureEvents = [self.interactor obtainFutureEventList];
    
    if (cachedFutureEvents.count > 0) {
        [self updateViewWithEvents:cachedFutureEvents];
    } else {
        [self.view showLoadingState];
    }
}

- (void)didTriggerEventTapEventWithObject:(EventPlainObject *)event {
    NSString *eventId = event.eventId;
    [self.router openEventModuleWithEventId:eventId];
}

- (void)didTriggerMoreEventsButtonTapEvent {
    [self.router openEventListModule];
}

#pragma mark - Методы EventGalleryInteractorOutput

- (void)didUpdateEventListWithFutureEvents:(NSArray<EventPlainObject *> *)events {
    [self updateViewWithEvents:events];
}

#pragma mark - Private methods

- (void)updateViewWithEvents:(NSArray *)events {
    [self.view showGalleryState];
    [self.view updateStateWithFutureEvents:events];
}

@end
