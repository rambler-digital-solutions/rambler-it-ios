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
#import "TagCellSizeCalculator.h"
#import "TagCellSizeRowCalculator.h"
#import "TagCellSizeConfig.h"
#import "TagCollectionViewCellObject.h"
#import "TagCollectionViewCell.h"

@interface TagCellSizeCalculatorTests : XCTestCase

@property (nonatomic, strong) TagCellSizeCalculator *calculator;
@property (nonatomic, strong) id mockRowCalculator;
@property (nonatomic, strong) TagCellSizeConfig *mockConfig;

@property (nonatomic, strong) id mockCellObject;
@property (nonatomic, strong) id mockCellNib;
@property (nonatomic, strong) id mockCell;

@end

const CGFloat kCalculatorContentWidth = 320.0f;
const CGFloat kCalculatorItemSpacing = 7.0f;

@implementation TagCellSizeCalculatorTests

- (void)setUp {
    [super setUp];

    self.mockConfig = [[TagCellSizeConfig alloc] initWithContentWidth:kCalculatorContentWidth
                                                          itemSpacing:kCalculatorItemSpacing];

    self.mockRowCalculator = OCMClassMock([TagCellSizeRowCalculator class]);

    self.calculator = [[TagCellSizeCalculator alloc] initWithRowCalculator:self.mockRowCalculator
                                                                    config:self.mockConfig];

    self.mockCellObject = OCMClassMock([TagCollectionViewCellObject class]);
    self.mockCellNib = OCMClassMock([UINib class]);

    OCMStub([self.mockCellObject collectionViewCellNib]).andReturn(self.mockCellNib);

    self.mockCell = OCMClassMock([TagCollectionViewCell class]);

    OCMStub([self.mockCellNib instantiateWithOwner:OCMOCK_ANY
                                           options:OCMOCK_ANY]).andReturn(@[self.mockCell]);
}

- (void)tearDown {

    self.calculator = nil;

    self.mockConfig = nil;

    [self.mockRowCalculator stopMocking];
    self.mockRowCalculator = nil;

    [self.mockCellObject stopMocking];
    self.mockCellObject = nil;

    [self.mockCell stopMocking];
    self.mockRowCalculator = nil;

    [self.mockCellNib stopMocking];
    self.mockCellNib = nil;

    [super tearDown];
}

- (void)testSizeForCellObject {
    // given
    CGSize cellSize = CGSizeMake(kCalculatorContentWidth * 2, 0);
    OCMStub([self.mockCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]).andReturn(cellSize);

    // when
    CGSize result = [self.calculator sizeForCellObject:self.mockCellObject];

    // then
    XCTAssertEqual(result.width, cellSize.width);
}

- (void)testCompressSizeForCellObject {
    // given
    CGSize cellSize = CGSizeMake(kCalculatorContentWidth * 2, 0);
    OCMStub([self.mockCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]).andReturn(cellSize);
    self.calculator.compressWidth = YES;

    // when
    CGSize result = [self.calculator sizeForCellObject:self.mockCellObject];

    // then
    XCTAssertEqual(result.width, kCalculatorContentWidth);
}

- (void)testCountItemsInRows {
    // given
    NSInteger countAddItems = 12;
    OCMStub([self.mockRowCalculator countAddItems]).andReturn(countAddItems);

    // when
    NSInteger result = [self.calculator countItemsInRows:0
                                          forCellObjects:nil
                                          lastCellObject:nil];

    // then
    XCTAssertEqual(result, countAddItems - 1);
}

- (void)testCountRowsForObject {
    // given
    NSInteger countRows = 12;
    OCMStub([self.mockRowCalculator countRows]).andReturn(countRows);

    // when
    NSInteger result = [self.calculator countRowsForObjects:nil];

    // then
    XCTAssertEqual(result, countRows);
}

@end
