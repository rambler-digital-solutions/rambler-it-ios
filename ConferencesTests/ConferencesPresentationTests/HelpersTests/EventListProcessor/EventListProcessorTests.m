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

#import <XCTest/XCTest.h>

#import "EventListProcessor.h"
#import "EventPlainObject.h"

@interface EventListProcessorTests : XCTestCase

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) EventListProcessor *eventListProcessor;

@end

@implementation EventListProcessorTests

- (void)setUp {
    [super setUp];

    self.eventListProcessor = [EventListProcessor new];
    self.dateFormatter = [NSDateFormatter new];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (void)tearDown {
    self.eventListProcessor = nil;
    self.dateFormatter = nil;

    [super tearDown];
}

- (void)testThatEventListProcessorSortEventsByDate {
    // given
    NSArray *unsortedEvents = [self fakeEventsArray];

    // when
    NSArray *sortedEvents = [self.eventListProcessor sortEventsByDate:unsortedEvents];

    // then
    EventPlainObject *recentEvent = [sortedEvents firstObject];
    EventPlainObject *oldEvent = [sortedEvents lastObject];
    XCTAssertTrue([oldEvent.startDate compare:recentEvent.startDate] == NSOrderedAscending);
}

- (NSArray *)fakeEventsArray {
    EventPlainObject *eventOne = [EventPlainObject new];
    eventOne.eventId = @"31";
    eventOne.startDate = [self.dateFormatter dateFromString:@"2015-06-26 19:00:00"];
    eventOne.name = @"eventOne";

    EventPlainObject *eventTwo = [EventPlainObject new];
    eventTwo.eventId = @"14";
    eventTwo.startDate = [self.dateFormatter dateFromString:@"2016-03-30 19:00:00"];
    eventTwo.name = @"eventTwo";

    EventPlainObject *eventThree = [EventPlainObject new];
    eventThree.eventId = @"36";
    eventThree.startDate = [self.dateFormatter dateFromString:@"2016-07-01 14:00:00"];
    eventThree.name = @"eventThree";

    EventPlainObject *eventFour = [EventPlainObject new];
    eventFour.eventId = @"15";
    eventFour.startDate = [NSDate date];
    eventFour.name = @"eventFour";

    return @[eventTwo, eventOne, eventThree, eventFour];
}

@end
