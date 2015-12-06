//
//  FutureEventCellObjectBuilderTests.m
//  Conferences
//
//  Created by Karpushin Artem on 21/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "FutureEventCellObjectBuilder.h"
#import "EventInfoTableViewCellObject.h"
#import "SignUpAndSaveToCalendarEventTableViewCellObject.h"
#import "EventDescriptionTableViewCellObject.h"
#import "LectureInfoTableViewCellObject.h"
#import "PlainEvent.h"
#import "PlainLecture.h"
#import "DateFormatter.h"

@interface FutureEventCellObjectBuilderTests : XCTestCase

@property (strong, nonatomic) FutureEventCellObjectBuilder *cellObjectBuilder;
@property (strong, nonatomic) DateFormatter *mockDateFormatter;

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
    self.mockDateFormatter = nil;

    [super tearDown];
}

- (void)testThatBuilderCreatesCorrectCellObjects {
    // given
    NSDate *eventStartDate = [NSDate date];
    
    PlainEvent *event = [PlainEvent new];
    event.startDate = eventStartDate;
    event.lectures = @[
                       [PlainLecture new],
                       [PlainLecture new],
                       [PlainLecture new]
                       ];
    
    NSUInteger const expectedNumberOfEventInfoTableViewCellObjects = 1;
    NSUInteger const expectedNumberOfSignUpAndSaveToCalendarEventTableViewCellObjects = 1;
    NSUInteger const expectedNumberOfEventDescriptionTableViewCellObjects = 1;
    NSUInteger const expectedNumberOfLectureInfoTableViewCellObjects = event.lectures.count;
    NSUInteger actualNumberOfEventInfoTableViewCellObjects = 0;
    NSUInteger actualNumberOfSignUpAndSaveToCalendarEventTableViewCellObjects = 0;
    NSUInteger actualNumberOfEventDescriptionTableViewCellObjects = 0;
    NSUInteger actualNumberOfLectureInfoTableViewCellObjects = 0;
    
    // when
    NSArray *cellObjects = [self.cellObjectBuilder cellObjectsForEvent:event];
    
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
    }
    
    // then
    XCTAssertEqual(expectedNumberOfEventInfoTableViewCellObjects, actualNumberOfEventInfoTableViewCellObjects);
    XCTAssertEqual(expectedNumberOfSignUpAndSaveToCalendarEventTableViewCellObjects, actualNumberOfSignUpAndSaveToCalendarEventTableViewCellObjects);
    XCTAssertEqual(expectedNumberOfEventDescriptionTableViewCellObjects, actualNumberOfEventDescriptionTableViewCellObjects);
    XCTAssertEqual(expectedNumberOfLectureInfoTableViewCellObjects, actualNumberOfLectureInfoTableViewCellObjects);
    OCMVerify([self.mockDateFormatter obtainDateWithDayMonthTimeFormat:eventStartDate]);
}

@end
