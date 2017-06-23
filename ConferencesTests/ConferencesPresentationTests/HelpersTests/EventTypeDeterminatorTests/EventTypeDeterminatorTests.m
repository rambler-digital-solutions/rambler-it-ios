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

#import "EventTypeDeterminator.h"
#import "EventPlainObject.h"
#import "EventType.h"

static NSUInteger const DefaultEventTestType = 111;

@interface EventTypeDeterminatorTests : XCTestCase

@property (nonatomic, strong) EventTypeDeterminator *typeDenerminator;

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
    
    EventPlainObject *event = [EventPlainObject new];
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
    
    EventPlainObject *event = [EventPlainObject new];
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
    
    EventPlainObject *event = [EventPlainObject new];
    event.startDate = eventStartDate;
    event.endDate = eventEndDate;
    
    // when
    actualEventType = [self.typeDenerminator determinateTypeForEvent:event];
    
    // then
    XCTAssertEqual(expectedEventType, actualEventType);
}

@end
