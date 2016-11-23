//
//  EventListProcessorTests.m
//  Conferences
//
//  Created by Trishina Ekaterina on 23/11/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "EventListProcessor.h"
#import "EventPlainObject.h"

@interface EventListProcessorTests : XCTestCase

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation EventListProcessorTests

- (void)setUp {
    [super setUp];

    self.dateFormatter = [NSDateFormatter new];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (void)tearDown {
    self.dateFormatter = nil;

    [super tearDown];
}

- (void)testThatEventListProcessorSortEventsByDate {
    // given
    NSArray *unsortedEvents = [self fakeEventsArray];

    // when
    NSArray *sortedEvents = [EventListProcessor sortEventsByDate:unsortedEvents];

    // then
    EventPlainObject *recentEvent = [sortedEvents firstObject];
    EventPlainObject *oldEvent = [sortedEvents lastObject];
    XCTAssertGreaterThan(oldEvent.startDate, recentEvent.startDate);
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
