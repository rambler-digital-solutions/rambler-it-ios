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
                                                          itemSpacing:kRowCalculatorItemSpacing
                                                           itemHeight:0
                                                        itemSideInset:0
                                                                 font:nil];;

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
