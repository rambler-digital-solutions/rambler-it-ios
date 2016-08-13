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

#import "FutureEventFilter.h"
#import "EventPlainObject.h"

@interface FutureEventFilterTests : XCTestCase

@property (nonatomic, strong) FutureEventFilter *filter;

@end

@implementation FutureEventFilterTests

- (void)setUp {
    [super setUp];
    
    self.filter = [FutureEventFilter new];
}

- (void)tearDown {
    self.filter = nil;
    
    [super tearDown];
}

- (void)testThatFilterFiltersFutureEvents {
    // given
    NSUInteger pastEventsCount = 10;
    NSUInteger futureEventsCount = 5;
    NSArray *events = [self generateEventsWithFutureEventsCount:futureEventsCount
                                                pastEventsCount:pastEventsCount];
    
    // when
    NSArray *result = [self.filter filterFutureEventsFromEvents:events];
    
    // then
    XCTAssertEqual(result.count, futureEventsCount);
}

#pragma mark - Private methods

- (NSArray *)generateEventsWithFutureEventsCount:(NSUInteger)futureEventsCount
                                 pastEventsCount:(NSUInteger)pastEventsCount {
    NSMutableArray *events = [NSMutableArray new];
    
    for (NSUInteger i = 0; i < futureEventsCount; i++) {
        EventPlainObject *event = [EventPlainObject new];
        event.endDate = [self generateFutureDate];
        [events addObject:event];
    }
    for (NSUInteger i = 0; i < pastEventsCount; i++) {
        EventPlainObject *event = [EventPlainObject new];
        event.endDate = [self generatePastDate];
        [events addObject:event];
    }
    return [events copy];
}

- (NSDate *)generateFutureDate {
    NSDate *currentDate = [NSDate date];
    NSDate *futureDate = [currentDate dateByAddingTimeInterval:100000];
    return futureDate;
}

- (NSDate *)generatePastDate {
    NSDate *currentDate = [NSDate date];
    NSDate *pastDate = [currentDate dateByAddingTimeInterval:-100000];
    return pastDate;
}

@end
