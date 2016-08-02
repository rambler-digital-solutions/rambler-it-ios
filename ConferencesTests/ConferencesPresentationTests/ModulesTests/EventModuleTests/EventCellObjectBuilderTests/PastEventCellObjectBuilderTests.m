//
//  PastEventCellObjectBuilderTests.m
//  Conferences
//
//  Created by Karpushin Artem on 21/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "ModelObjectGenerator.h"

#import "PastEventCellObjectBuilder.h"
#import "EventInfoTableViewCellObject.h"
#import "VideoRecordTableViewCellObject.h"
#import "EventDescriptionTableViewCellObject.h"
#import "LectureInfoTableViewCellObject.h"
#import "EventPlainObject.h"
#import "LecturePlainObject.h"
#import "DateFormatter.h"
#import "EventCellObjectBuilderConstants.h"
#import "PreviousLectureTableViewCellObject.h"
#import "PreviousEventTableViewCellObject.h"

@interface PastEventCellObjectBuilderTests : XCTestCase

@property (strong, nonatomic) PastEventCellObjectBuilder *cellObjectBuilder;
@property (strong, nonatomic) id mockDateFormatter;

@end

@implementation PastEventCellObjectBuilderTests

- (void)setUp {
    [super setUp];
    
    self.cellObjectBuilder = [PastEventCellObjectBuilder new];
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
    NSUInteger const expectedNumberOfVideoRecordEventTableViewCellObjects = 1;
    NSUInteger const expectedNumberOfEventDescriptionTableViewCellObjects = 1;
    NSUInteger const expectedNumberOfLectureInfoTableViewCellObjects = event.lectures.count;
    NSUInteger const expectedNumberOfPastEventsInfoTableViewCellObjects = kEventPastEventsCount;
    NSUInteger const expectedNumberOfPastLectureInfoTableViewCellObjects = kEventPastEventLecturesCount;
    
    NSUInteger actualNumberOfEventInfoTableViewCellObjects = 0;
    NSUInteger actualNumberOfVideoRecordEventTableViewCellObjects = 0;
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
        if ([cellObject isKindOfClass:[VideoRecordTableViewCellObject class]]) {
            actualNumberOfVideoRecordEventTableViewCellObjects++;
        }
        if ([cellObject isKindOfClass:[EventDescriptionTableViewCellObject class]]) {
            actualNumberOfEventDescriptionTableViewCellObjects++;
        }
        if ([cellObject isKindOfClass:[LectureInfoTableViewCellObject class]]) {
            actualNumberOfLectureInfoTableViewCellObjects++;
        }
        if ([cellObject isKindOfClass:[PreviousEventTableViewCellObject class]]) {
            actualNumberOfPastEventsInfoTableViewCellObjects++;
        }
        if ([cellObject isKindOfClass:[PreviousLectureTableViewCellObject class]]) {
            actualNumberOfPastLectureInfoTableViewCellObjects++;
        }
    }
    
    // then
    XCTAssertEqual(expectedNumberOfEventInfoTableViewCellObjects, actualNumberOfEventInfoTableViewCellObjects);
    XCTAssertEqual(expectedNumberOfVideoRecordEventTableViewCellObjects, actualNumberOfVideoRecordEventTableViewCellObjects);
    XCTAssertEqual(expectedNumberOfEventDescriptionTableViewCellObjects, actualNumberOfEventDescriptionTableViewCellObjects);
    XCTAssertEqual(expectedNumberOfLectureInfoTableViewCellObjects, actualNumberOfLectureInfoTableViewCellObjects);
    XCTAssertEqual(expectedNumberOfPastEventsInfoTableViewCellObjects, actualNumberOfPastEventsInfoTableViewCellObjects);
    XCTAssertEqual(expectedNumberOfPastLectureInfoTableViewCellObjects, actualNumberOfPastLectureInfoTableViewCellObjects);
    
    OCMVerify([self.mockDateFormatter obtainDateWithDayMonthTimeFormat:eventStartDate]);
}

@end
