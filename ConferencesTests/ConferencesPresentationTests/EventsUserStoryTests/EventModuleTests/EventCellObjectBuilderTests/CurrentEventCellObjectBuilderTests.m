//
//  CurrentEventCellObjectBuilderTests.m
//  Conferences
//
//  Created by Karpushin Artem on 21/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CurrentEventCellObjectBuilder.h"
#import "EventInfoTableViewCellObject.h"
#import "CurrentVideoTranslationTableViewCellObject.h"
#import "PlainEvent.h"

@interface CurrentEventCellObjectBuilderTests : XCTestCase

@property (strong, nonatomic) CurrentEventCellObjectBuilder *cellObjectBuilder;

@end

@implementation CurrentEventCellObjectBuilderTests

- (void)setUp {
    [super setUp];
    
    self.cellObjectBuilder = [CurrentEventCellObjectBuilder new];
}

- (void)tearDown {
    self.cellObjectBuilder = nil;

    [super tearDown];
}

- (void)testThatBuilderCreatesCorrectCellObjects {
    // given
    NSUInteger const expectedNumberOfEventInfoTableViewCellObjects = 1;
    NSUInteger const expectedNumberOfCurrentVideoTranslationTableViewCellObjects = 1;
    NSUInteger actualNumberOfEventInfoTableViewCellObjects = 0;
    NSUInteger actualNumberOfCurrentVideoTranslationTableViewCellObjects = 0;
    
    PlainEvent *event = [PlainEvent new];
    
    // when
    NSArray *cellObjects = [self.cellObjectBuilder cellObjectsForEvent:event];
    
    for (id cellObject in cellObjects) {
        if ([cellObject isKindOfClass:[EventInfoTableViewCellObject class]]) {
            actualNumberOfEventInfoTableViewCellObjects++;
        }
        if ([cellObject isKindOfClass:[CurrentVideoTranslationTableViewCellObject class]]) {
            actualNumberOfCurrentVideoTranslationTableViewCellObjects++;
        }
    }
    
    // then
    XCTAssertEqual(expectedNumberOfEventInfoTableViewCellObjects, actualNumberOfEventInfoTableViewCellObjects);
    XCTAssertEqual(expectedNumberOfCurrentVideoTranslationTableViewCellObjects, actualNumberOfCurrentVideoTranslationTableViewCellObjects);
}

@end
