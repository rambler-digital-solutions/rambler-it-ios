//
//  PastEventCellObjectBuilderTests.m
//  Conferences
//
//  Created by Karpushin Artem on 21/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PastEventCellObjectBuilder.h"
#import "EventInfoTableViewCellObject.h"
#import "PastVideoTranslationTableViewCellObject.h"
#import "EventDescriptionTableViewCellObject.h"
#import "LectureInfoTableViewCellObject.h"
#import "PlainEvent.h"
#import "PlainLecture.h"

@interface PastEventCellObjectBuilderTests : XCTestCase

@property (strong, nonatomic) PastEventCellObjectBuilder *cellObjectBuilder;

@end

@implementation PastEventCellObjectBuilderTests

- (void)setUp {
    [super setUp];
    
    self.cellObjectBuilder = [PastEventCellObjectBuilder new];
}

- (void)tearDown {
    self.cellObjectBuilder = nil;

    [super tearDown];
}

- (void)testThatBuilderCreatesCorrectCellObjects {
    // given
    PlainEvent *event = [PlainEvent new];
    event.lectures = @[
                       [PlainLecture new],
                       [PlainLecture new],
                       [PlainLecture new]
                       ];
    
    NSUInteger const expectedNumberOfEventInfoTableViewCellObjects = 1;
    NSUInteger const expectedNumberOfPastVideoTranslationTableViewCellObjects = 1;
    NSUInteger const expectedNumberOfEventDescriptionTableViewCellObjects = 1;
    NSUInteger const expectedNumberOfLectureInfoTableViewCellObjects = event.lectures.count;
    NSUInteger actualNumberOfEventInfoTableViewCellObjects = 0;
    NSUInteger actualNumberOfPastVideoTranslationTableViewCellObjects = 0;
    NSUInteger actualNumberOfEventDescriptionTableViewCellObjects = 0;
    NSUInteger actualNumberOfLectureInfoTableViewCellObjects = 0;
    
    // when
    NSArray *cellObjects = [self.cellObjectBuilder cellObjectsForEvent:event];
    
    for (id cellObject in cellObjects) {
        if ([cellObject isKindOfClass:[EventInfoTableViewCellObject class]]) {
            actualNumberOfEventInfoTableViewCellObjects++;
        }
        if ([cellObject isKindOfClass:[PastVideoTranslationTableViewCellObject class]]) {
            actualNumberOfPastVideoTranslationTableViewCellObjects++;
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
    XCTAssertEqual(expectedNumberOfPastVideoTranslationTableViewCellObjects, actualNumberOfPastVideoTranslationTableViewCellObjects);
    XCTAssertEqual(expectedNumberOfEventDescriptionTableViewCellObjects, actualNumberOfEventDescriptionTableViewCellObjects);
    XCTAssertEqual(expectedNumberOfLectureInfoTableViewCellObjects, actualNumberOfLectureInfoTableViewCellObjects);
}

@end
