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
#import <objc/objc.h>
#import "TagDataDisplayManager.h"
#import "TagCellSizeCalculator.h"
#import "TagCollectionViewCell.h"
#import "TagCollectionViewCellObject.h"
#import "XCTestCase+CollectionViewDataDisplayManager.h"
#import "TagModuleTableViewCellObject.h"

@interface TagDataDisplayManagerTests : XCTestCase

@property (nonatomic, strong) TagDataDisplayManager *dataDisplayManager;
@property (nonatomic, strong) id mockCellSizeCalculator;

@end

@implementation TagDataDisplayManagerTests

- (void)setUp {
    [super setUp];

    self.dataDisplayManager = [TagDataDisplayManager new];

    self.mockCellSizeCalculator = OCMClassMock([TagCellSizeCalculator class]);

    self.dataDisplayManager.cellSizeCalculator = self.mockCellSizeCalculator;
}

- (void)tearDown {

    self.dataDisplayManager = nil;

    self.mockCellSizeCalculator = nil;

    [super tearDown];
}

#pragma mark - Тестирование ячеек

- (void)testThatDataDisplayManagerReturnsPropperNumberOfCells {
    // given
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                          collectionViewLayout:layout];
    NSArray *tags = [self createTags];

    id <UICollectionViewDataSource> dataSource = [self.dataDisplayManager dataSourceForCollectionView:collectionView
                                                                                             withTags:tags];


    NSArray *expectedCellCounts = @[@3];

    // when
    NSMutableArray *result = [NSMutableArray array];
    for (int sectionIndex = 0; sectionIndex < expectedCellCounts.count; ++sectionIndex) {
        NSInteger rows = [dataSource collectionView:collectionView
                          numberOfItemsInSection:sectionIndex];
        [result addObject:@(rows)];
    }

    // then
    XCTAssertEqualObjects(expectedCellCounts, result);
}

- (void)testThatDataDisplayManagerReturnsProperTypeCells {
    // given
    id mockCollectionView = OCMClassMock([UICollectionView class]);
    NSArray *tags = [self createTags];

    id <UICollectionViewDataSource> dataSource = [self.dataDisplayManager dataSourceForCollectionView:mockCollectionView
                                                                                             withTags:tags];

    [self stubCollectionViewCells:mockCollectionView];

    NSArray *expectedCellsClass = @[[TagCollectionViewCell class],
                                    [TagCollectionViewCell class],
                                    [TagCollectionViewCell class]];

    // when
    NSArray *cellsClass = [self collectCellClasses:mockCollectionView
                                        dataSource:dataSource];

            // then
    XCTAssertEqualObjects(expectedCellsClass, cellsClass);
}

- (void)testThatDataDisplayManagerConfigureTagCollectionViewCell {
    // given
    NSArray *tags = [self createTags];
    NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:0
                                                    inSection:0];
    id mockCell = OCMClassMock([TagCollectionViewCell class]);
    NSString *cellIdentifier = NSStringFromClass([TagCollectionViewCellObject class]);
    id<UICollectionViewDataSource> dataSource = [self.dataDisplayManager dataSourceForCollectionView:nil
                                                                                            withTags:tags];
    
    // when
    [self testCollectionViewViewDataSource:dataSource
                              withMockCell:mockCell
                    originalCellIdentifier:cellIdentifier
                             testIndexPath:cellIndexPath];

    // then
    OCMVerify([mockCell shouldUpdateCellWithObject:OCMOCK_ANY]);
}

#pragma mark - Тестирование методов инетрфейса

- (void)testDelegateForCollectionView {
    // given

    // when
    id result = [self.dataDisplayManager delegateForCollectionView:nil];

    // then
    XCTAssertEqualObjects(result, self.dataDisplayManager);
}

- (void)testDataSourceForCollectionView {
    // given

    // when
    id result = [self.dataDisplayManager dataSourceForCollectionView:nil
                                                            withTags:nil];

    // then
    XCTAssertNotNil(result);
}

- (void)testSetCompressWidth {
    // given
    BOOL compressWidth = YES;

    // when
    [self.dataDisplayManager setCompressWidth:compressWidth];

    // then
    OCMVerify([self.mockCellSizeCalculator setCompressWidth:compressWidth]);

}

- (void)testCollapseCells {
    // given
    NSArray *tags = @[@"tag 1", @"tag 2", @"tag 3"];
    NSInteger countShowLines = 1;
    NSInteger tagRows = 3;
    NSInteger showTags = 1;
    NSInteger expectedRows = showTags;
    [self stubCountShowLines:countShowLines
                countTagRows:tagRows
                    showTags:showTags];

    id mockCollectionView = OCMClassMock([UICollectionView class]);
    [self stubCollectionViewCells:mockCollectionView];

    self.dataDisplayManager.numberOfShowLine = countShowLines;

    // when
    id <UICollectionViewDataSource> dataSource = [self.dataDisplayManager dataSourceForCollectionView:mockCollectionView
                                                                                             withTags:tags];

    // then
    NSInteger rows = [dataSource collectionView:mockCollectionView
                         numberOfItemsInSection:0];
    XCTAssertEqual(rows, expectedRows);
}

- (void)stubCountShowLines:(NSInteger)countShowLines
              countTagRows:(NSInteger)tagRows
                  showTags:(NSInteger)showTags {
    OCMStub([self.mockCellSizeCalculator countRowsForObjects:OCMOCK_ANY]).andReturn(tagRows);
    OCMStub([self.mockCellSizeCalculator countItemsInRows:countShowLines
                                           forCellObjects:OCMOCK_ANY
                                           lastCellObject:OCMOCK_ANY]).andReturn(showTags);
}

#pragma mark - Тестирование методов UICollectionViewDelegateFlowLayout

- (void)testSizeForItemAtIndexPath {
    // given
    id collectionView = [NSObject new];
    id layout = [NSObject new];
    id indexPath = [NSObject new];

    // when
    [self.dataDisplayManager collectionView:collectionView
                                     layout:layout
                     sizeForItemAtIndexPath:indexPath];

    // then
    OCMVerify([self.mockCellSizeCalculator sizeForCellObject:OCMOCK_ANY]);
}


- (void)testInsetForTagSection {
    // given
    id collectionView = [NSObject new];
    id layout = [NSObject new];
    NSInteger sectionIndex = 0;
    UIEdgeInsets expectedInsets = UIEdgeInsetsZero;

    // when
    UIEdgeInsets result = [self.dataDisplayManager collectionView:collectionView
                                                           layout:layout
                                           insetForSectionAtIndex:sectionIndex];

    // then
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(expectedInsets, result));
}

- (void)testInsetForAddButtonSection {
    // given
    id collectionView = [NSObject new];
    id layout = [NSObject new];
    NSInteger sectionIndex = 1;
    UIEdgeInsets expectedInsets = UIEdgeInsetsMake(5, 0, 0, 0);

    // when
    UIEdgeInsets result = [self.dataDisplayManager collectionView:collectionView
                                                           layout:layout
                                           insetForSectionAtIndex:sectionIndex];

    // then
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(expectedInsets, result));
}

#pragma mark - Тестирование методов TagCellDelegate

- (void)stubCollectionViewCells:(id)mockCollectionView {
    OCMStub([mockCollectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TagCollectionViewCellObject class])
                                                          forIndexPath:OCMOCK_ANY]).andReturn([TagCollectionViewCell new]);
}

- (NSArray *)collectCellClasses:(UICollectionView *)collectionView
                            dataSource:(id <UICollectionViewDataSource>)dataSource {
    NSMutableArray *cellsClass = [[NSMutableArray alloc] init];

    NSInteger sections = [dataSource numberOfSectionsInCollectionView:collectionView];
    for (int section = 0; section < sections; section++) {
        NSInteger rows = [dataSource collectionView:collectionView
                             numberOfItemsInSection:section];
        for (int row = 0; row < rows; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row
                                                        inSection:section];
            UICollectionViewCell *cell = [dataSource collectionView:collectionView
                                             cellForItemAtIndexPath:indexPath];
            [cellsClass addObject:[cell class]];
        }
    }
    return [cellsClass copy];
}

- (NSArray *)createTags {
    return @[@"tag 1", @"tag 2", @"tag 3"];
}

@end
