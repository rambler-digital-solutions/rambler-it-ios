//
//  SpeakerInfoDataDisplayManagerTests.m
//  Conferences
//
//  Created by Vasyura Anastasiya on 05/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "SpeakerInfoDataDisplayManager.h"
#import "SpeakerInfoCellObjectBuilder.h"
#import "SpeakerInfoSectionHeaderCellObject.h"
#import "SpeakerInfoTableViewCellObject.h"
#import "SpeakerInfoSocialContactsCellObject.h"
#import "SpeakerInfoSocialContactsTableViewCell.h"
#import "SpeakerInfoSectionHeaderTableViewCell.h"
#import "SpeakerInfoTableViewCell.h"

@interface SpeakerInfoDataDisplayManagerTests : XCTestCase

@property (nonatomic, strong) SpeakerInfoDataDisplayManager *dataDisplayManager;
@property (nonatomic, strong) id mockCellObjectsBuilder;

@end

@implementation SpeakerInfoDataDisplayManagerTests

- (void)setUp {
    [super setUp];
    self.dataDisplayManager = [SpeakerInfoDataDisplayManager new];
    
    self.mockCellObjectsBuilder = OCMClassMock([SpeakerInfoCellObjectBuilder class]);
    
    self.dataDisplayManager.cellObjectBuilder = self.mockCellObjectsBuilder;
}

- (void)tearDown {
    self.dataDisplayManager = nil;
    
    [self.mockCellObjectsBuilder stopMocking];
    self.mockCellObjectsBuilder = nil;
    
    [super tearDown];
}

- (void)testSuccessConfigureDataDisplayManagerWithEvent {
    // given
    id speaker = [NSObject new];
    id speakerInfo = [SpeakerInfoTableViewCellObject new];
    id sectionHeader = [SpeakerInfoSectionHeaderCellObject new];
    id socialNetwork = [SpeakerInfoSocialContactsCellObject new];
    UITableView *tableView = [UITableView new];
    
    NSArray *cellObjects = @[speakerInfo, sectionHeader, socialNetwork];
    NSArray *cellClasses = @[[SpeakerInfoTableViewCell class], [SpeakerInfoSectionHeaderTableViewCell class], [SpeakerInfoSocialContactsTableViewCell class]];
    
    OCMStub([self.mockCellObjectsBuilder buildObjectsWithSpeaker:speaker]).andReturn(cellObjects);
    
    // when
    [self.dataDisplayManager configureDataDisplayManagerWithSpeaker:speaker];
    id<UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:tableView];
    tableView.dataSource = dataSource;

    // then
    for (NSInteger index = 0; index < 3; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        UITableViewCell *cell = [dataSource tableView:tableView
                                cellForRowAtIndexPath:indexPath];
        Class class = cellClasses[index];
        XCTAssertEqual(class, cell.class);
    }
}

- (void)testThatDataDisplayManagerReturnsTableViewDataSource{
    // given
    
    // when
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:nil];
    
    // then
    XCTAssertNotNil(dataSource);
}

@end
