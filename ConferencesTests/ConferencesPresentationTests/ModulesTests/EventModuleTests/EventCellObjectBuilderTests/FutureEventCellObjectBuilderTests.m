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
#import <OCMock/OCMock.h>

#import "FutureEventCellObjectBuilder.h"
#import "EventInfoTableViewCellObject.h"
#import "SignUpAndSaveToCalendarEventTableViewCellObject.h"
#import "EventDescriptionTableViewCellObject.h"
#import "EventAnnouncementTableViewCellObject.h"
#import "LectureInfoTableViewCellObject.h"
#import "PreviousLectureTableViewCellObject.h"
#import "EventPlainObject.h"
#import "LecturePlainObject.h"
#import "DateFormatter.h"
#import "ModelObjectGenerator.h"
#import "EventCellObjectBuilderConstants.h"

@interface FutureEventCellObjectBuilderTests : XCTestCase

@property (strong, nonatomic) FutureEventCellObjectBuilder *cellObjectBuilder;
@property (strong, nonatomic) id mockDateFormatter;

@end

@implementation FutureEventCellObjectBuilderTests

- (void)setUp {
    [super setUp];
    
    self.cellObjectBuilder = [FutureEventCellObjectBuilder new];
    self.mockDateFormatter = OCMClassMock([DateFormatter class]);
    
    self.cellObjectBuilder.dateFormatter = self.mockDateFormatter;
}

- (void)tearDown {
    self.cellObjectBuilder = nil;
    
    [self.mockDateFormatter stopMocking];
    self.mockDateFormatter = nil;

    [super tearDown];
}

- (void)testThatBuilderCreatesCorrectCellObjects {
    // given
    NSDate *eventStartDate = [NSDate date];
    EventPlainObject *event = [ModelObjectGenerator generateEventObjects:1].firstObject;
    event.startDate = eventStartDate;
    
    NSArray *pastEvents = [ModelObjectGenerator generateEventObjects:4];
    
    NSUInteger const expectedNumberOfEventInfoTableViewCellObjects = 1;
    NSUInteger const expectedNumberOfSignUpAndSaveToCalendarEventTableViewCellObjects = 1;
    NSUInteger const expectedNumberOfEventDescriptionTableViewCellObjects = 1;
    NSUInteger const expectedNumberOfLectureInfoTableViewCellObjects = event.lectures.count;
    NSUInteger const expectedNumberOfPastEventsInfoTableViewCellObjects = kEventPastEventsCount;
    NSUInteger const expectedNumberOfPastLectureInfoTableViewCellObjects = kEventPastEventLecturesCount;

    NSUInteger actualNumberOfEventInfoTableViewCellObjects = 0;
    NSUInteger actualNumberOfSignUpAndSaveToCalendarEventTableViewCellObjects = 0;
    NSUInteger actualNumberOfEventDescriptionTableViewCellObjects = 0;
    NSUInteger actualNumberOfLectureInfoTableViewCellObjects = 0;
    NSUInteger actualNumberOfPastEventsInfoTableViewCellObjects = 0;
    NSUInteger actualNumberOfPastLectureInfoTableViewCellObjects = 0;
    
    // when
    NSArray *cellObjects = [self.cellObjectBuilder cellObjectsForEvent:event
                                                            pastEvents:pastEvents];
    
    for (id cellObject in cellObjects) {
        if ([cellObject isKindOfClass:[EventInfoTableViewCellObject class]]) {
            actualNumberOfEventInfoTableViewCellObjects++;
        }
        if ([cellObject isKindOfClass:[SignUpAndSaveToCalendarEventTableViewCellObject class]]) {
            actualNumberOfSignUpAndSaveToCalendarEventTableViewCellObjects++;
        }
        if ([cellObject isKindOfClass:[EventDescriptionTableViewCellObject class]]) {
            actualNumberOfEventDescriptionTableViewCellObjects++;
        }
        if ([cellObject isKindOfClass:[LectureInfoTableViewCellObject class]]) {
            actualNumberOfLectureInfoTableViewCellObjects++;
        }
        if ([cellObject isKindOfClass:[EventAnnouncementTableViewCellObject class]]) {
            actualNumberOfPastEventsInfoTableViewCellObjects++;
        }
        if ([cellObject isKindOfClass:[PreviousLectureTableViewCellObject class]]) {
            actualNumberOfPastLectureInfoTableViewCellObjects++;
        }
    }
    
    // then
    XCTAssertEqual(expectedNumberOfEventInfoTableViewCellObjects, actualNumberOfEventInfoTableViewCellObjects);
    XCTAssertEqual(expectedNumberOfSignUpAndSaveToCalendarEventTableViewCellObjects, actualNumberOfSignUpAndSaveToCalendarEventTableViewCellObjects);
    XCTAssertEqual(expectedNumberOfEventDescriptionTableViewCellObjects, actualNumberOfEventDescriptionTableViewCellObjects);
    XCTAssertEqual(expectedNumberOfLectureInfoTableViewCellObjects, actualNumberOfLectureInfoTableViewCellObjects);
    XCTAssertEqual(expectedNumberOfPastEventsInfoTableViewCellObjects, actualNumberOfPastEventsInfoTableViewCellObjects);
    XCTAssertEqual(expectedNumberOfPastLectureInfoTableViewCellObjects, actualNumberOfPastLectureInfoTableViewCellObjects);

    OCMVerify([self.mockDateFormatter obtainDateWithDayMonthTimeFormat:eventStartDate]);
}

@end
