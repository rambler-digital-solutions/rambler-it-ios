//
//  EventTypeDeterminatorTests.m
//  Conferences
//
//  Created by Karpushin Artem on 22/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "EventTypeDeterminator.h"
#import "PlainEvent.h"
#import "EventType.h"

static NSUInteger const DefaultEventTestType = 111;

@interface EventTypeDeterminatorTests : XCTestCase

@property (strong, nonatomic) EventTypeDeterminator *typeDenerminator;

@end

@implementation EventTypeDeterminatorTests

- (void)setUp {
    [super setUp];
    
    self.typeDenerminator = [EventTypeDeterminator new];
}

- (void)tearDown {
    self.typeDenerminator = nil;

    [super tearDown];
}

- (void)testSuccessDeterminateCurrentEventType {
    // given
    EventType expectedEventType = CurrentEvent;
    EventType actualEventType = DefaultEventTestType;
    
    NSTimeInterval hour = 60 * 60;
    
    NSDate *eventStartDate = [[NSDate date] dateByAddingTimeInterval: - hour];
    NSDate *eventEndDate = [[NSDate date] dateByAddingTimeInterval:hour];
    
    PlainEvent *event = [PlainEvent new];
    event.startDate = eventStartDate;
    event.endDate = eventEndDate;
    
    // when
    actualEventType = [self.typeDenerminator determinateTypeForEvent:event];
    
    // then
    XCTAssertEqual(expectedEventType, actualEventType);
}

- (void)testSuccessDeterminateFutureEventType {
    // given
    EventType expectedEventType = FutureEvent;
    EventType actualEventType = DefaultEventTestType;
    
    NSTimeInterval hour = 60 * 60;
    
    NSDate *eventStartDate = [[NSDate date] dateByAddingTimeInterval:hour];
    NSDate *eventEndDate = [[NSDate date] dateByAddingTimeInterval:hour + hour];
    
    PlainEvent *event = [PlainEvent new];
    event.startDate = eventStartDate;
    event.endDate = eventEndDate;
    
    // when
    actualEventType = [self.typeDenerminator determinateTypeForEvent:event];
    
    // then
    XCTAssertEqual(expectedEventType, actualEventType);
}

- (void)testSuccessDeterminatePastEventType {
    // given
    EventType expectedEventType = PastEvent;
    EventType actualEventType = DefaultEventTestType;
    
    NSTimeInterval hour = 60 * 60;
    
    NSDate *eventStartDate = [[NSDate date] dateByAddingTimeInterval: - hour - hour];
    NSDate *eventEndDate = [[NSDate date] dateByAddingTimeInterval: - hour];
    
    PlainEvent *event = [PlainEvent new];
    event.startDate = eventStartDate;
    event.endDate = eventEndDate;
    
    // when
    actualEventType = [self.typeDenerminator determinateTypeForEvent:event];
    
    // then
    XCTAssertEqual(expectedEventType, actualEventType);
}

@end
