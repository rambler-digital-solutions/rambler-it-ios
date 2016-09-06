//
//  TagCellSizeRowCalculatorTests.m
//  LiveJournal
//
//  Created by Golovko Mikhail on 31/12/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TagCellSizeRowCalculator.h"
#import "TagCellSizeConfig.h"

@interface TagCellSizeRowCalculatorTests : XCTestCase

@property (nonatomic, strong) TagCellSizeRowCalculator *calculator;
@property (nonatomic, strong) TagCellSizeConfig *mockConfig;

@end

const CGFloat kRowCalculatorContentWidth = 320.0f;
const CGFloat kRowCalculatorItemSpacing = 7.0f;

@implementation TagCellSizeRowCalculatorTests

- (void)setUp {
    [super setUp];

    self.mockConfig = [[TagCellSizeConfig alloc] initWithContentWidth:kRowCalculatorContentWidth
                                                          itemSpacing:kRowCalculatorItemSpacing];

    self.calculator = [[TagCellSizeRowCalculator alloc] initWithConfig:self.mockConfig];
}

- (void)tearDown {

    self.calculator = nil;

    self.mockConfig = nil;

    [super tearDown];
}

- (void)testAddItemAtWidth {
    // given
    CGFloat itemWidth = 80;
    CGFloat expectedCountRows = 1;
    CGFloat expectedCountItems = 3;

    // when

    for (int i = 0; i < expectedCountItems; ++i) {
        [self.calculator addItemAtWidth:itemWidth];
    }

    // then
    XCTAssertEqual(self.calculator.countRows, expectedCountRows);
    XCTAssertEqual(self.calculator.countAddItems, expectedCountItems);
}

- (void)testAddItemInSameRowAtWidth {
    // given
    CGFloat itemWidth = 1;
    
    // when
    [self.calculator addItemAtWidth:kRowCalculatorContentWidth];
    BOOL result = [self.calculator addItemInSameRowAtWidth:itemWidth];

    // then
    XCTAssertFalse(result);
}

- (void)testCleanRows {
    CGFloat expectedCountRows = 0;
    CGFloat expectedCountItems = 0;

    // given
    [self.calculator addItemAtWidth:kRowCalculatorContentWidth];

    // when
    [self.calculator cleanRows];

    // then
    XCTAssertEqual(self.calculator.countRows, expectedCountRows);
    XCTAssertEqual(self.calculator.countAddItems, expectedCountItems);
}

- (void)testAddNewRow {
    // given
    CGFloat expectedCountRows = 1;

    // when
    [self.calculator addNewRow];

    // then
    XCTAssertEqual(self.calculator.countRows, expectedCountRows);
}

@end
