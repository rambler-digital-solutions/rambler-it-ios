//
//  TagCollectionViewTests.m
//  liveJournal
//
//  Created by Golovko Mikhail on 15/12/2015.
//  Copyright 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "TagCollectionView.h"
#import "TagModuleInput.h"
#import "TagDataDisplayManager.h"
#import "TagCellSizeCalculator.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "TagModuleConfig.h"
#import "TagCellSizeConfig.h"

@interface TagCollectionViewTests : XCTestCase

@property (strong, nonatomic) TagCollectionView *view;

@property (strong, nonatomic) id mockModuleInput;
@property (strong, nonatomic) id mockDataDisplayManager;
@property (strong, nonatomic) TagCellSizeConfig *cellSizeConfig;

@end

@implementation TagCollectionViewTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
    [super setUp];

    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    self.view = [[TagCollectionView alloc] initWithFrame:CGRectZero
                                    collectionViewLayout:layout];

    self.mockModuleInput = OCMProtocolMock(@protocol(TagModuleInput));
    self.mockDataDisplayManager = OCMClassMock([TagDataDisplayManager class]);
    self.cellSizeConfig = [TagCellSizeConfig defaultConfig];

    self.view.moduleInput = self.mockModuleInput;
    self.view.dataDisplayManager = self.mockDataDisplayManager;
    self.view.cellSizeConfig = self.cellSizeConfig;
}

- (void)tearDown {
    self.view = nil;

    self.mockModuleInput = nil;
    self.mockDataDisplayManager = nil;

    [super tearDown];
}

#pragma mark - Тестирование методов TagViewInput

- (void)testSetupInitialState {
    // given

    // when
    [self.view setupInitialState];

    // then
    OCMVerify([self.mockDataDisplayManager delegateForCollectionView:self.view]);
}

- (void)testShowTags {
    // given
    id tags = [NSArray new];

    // when
    [self.view showTags:tags];

    // then
    OCMVerify([self.mockDataDisplayManager dataSourceForCollectionView:self.view
                                                              withTags:tags]);
}

- (void)testSetupVerticalContentAlign {
    // given
    CGFloat kExpectedSpacing = self.cellSizeConfig.itemSpacing;

    // when
    [self.view setupVerticalContentAlign];

    // then
    XCTAssertEqualObjects([self.view.collectionViewLayout class], [UICollectionViewLeftAlignedLayout class]);
    UICollectionViewLeftAlignedLayout *layout = (UICollectionViewLeftAlignedLayout *) self.view.collectionViewLayout;
    XCTAssertEqual([layout minimumInteritemSpacing], kExpectedSpacing);
    XCTAssertEqual([layout minimumLineSpacing], kExpectedSpacing);
    XCTAssertEqual([layout scrollDirection], UICollectionViewScrollDirectionVertical);
    XCTAssertFalse(self.view.scrollEnabled);
    XCTAssertFalse(self.view.alwaysBounceHorizontal);
    XCTAssertFalse(self.view.showsVerticalScrollIndicator);
    OCMVerify([self.mockDataDisplayManager setCompressWidth:YES]);
}

- (void)testSetupHorizontalContentAlign {
    // given
    CGFloat kExpectedSpacing = self.cellSizeConfig.itemSpacing;

    // when
    [self.view setupHorizontalContentAlign];

    // then
    XCTAssertEqualObjects([self.view.collectionViewLayout class], [UICollectionViewFlowLayout class]);
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.view.collectionViewLayout;
    XCTAssertEqual([layout minimumInteritemSpacing], kExpectedSpacing);
    XCTAssertEqual([layout minimumLineSpacing], kExpectedSpacing);
    XCTAssertEqual([layout scrollDirection], UICollectionViewScrollDirectionHorizontal);
    XCTAssertTrue(self.view.scrollEnabled);
    XCTAssertTrue(self.view.alwaysBounceHorizontal);
    XCTAssertFalse(self.view.showsHorizontalScrollIndicator);
    OCMVerify([self.mockDataDisplayManager setCompressWidth:NO]);
}
- (void)testSetupShowNumberOfLines {
    // given
    NSInteger numberShowLines = 4;
    
    // when
    [self.view setupShowNumberOfLines:numberShowLines];
    
    // then
    OCMVerify([self.mockDataDisplayManager setNumberOfShowLine:numberShowLines]);
}

#pragma mark - Тестирование методов TagModuleInput

- (void)testForwardConfigureModuleWithModuleConfig {
    // given
    id moduleConfig = [NSObject new];
    id moduleOutput = [NSObject new];

    // when
    [self.view configureModuleWithModuleConfig:moduleConfig
                                  moduleOutput:moduleOutput];

    // then
    OCMVerify([self.mockModuleInput configureModuleWithModuleConfig:moduleConfig
                                                       moduleOutput:moduleOutput]);
}

@end