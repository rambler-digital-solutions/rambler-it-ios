//
//  EventListDataDisplayManagerTests.m
//  Conferences
//
//  Created by Karpushin Artem on 15/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "EventListDataDisplayManager.h"
#import "PlainEvent.h"
#import "FutureEventTableViewCell.h"
#import "PastEventTableViewCell.h"

#import <OCMock/OCMock.h>
#import "EventListTableViewController.h"

@interface EventListDataDisplayManagerTests : XCTestCase

@property (strong, nonatomic) EventListDataDisplayManager *dataDisplayManager;
@property (strong, nonatomic) NSArray *events;

@end

@implementation EventListDataDisplayManagerTests

- (void)setUp {
    [super setUp];
    
    self.dataDisplayManager = [EventListDataDisplayManager new];
    self.events = [self generateEvents];
}

- (void)tearDown {
    self.dataDisplayManager = nil;
    self.events = nil;
    
    [super tearDown];
}

- (void)testThatDataDisplayManagerReturnsTableViewDataSource{
    // given
    
    // when
    [self.dataDisplayManager updateTableViewModelWithEvents:self.events];
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:nil];
    
    // then
    XCTAssertNotNil(dataSource);
}

- (void)testSuccessUpdateTableViewModelWithEvents {
    // given
    id mockViewController = OCMClassMock([EventListTableViewController class]);
    self.dataDisplayManager.delegate = mockViewController;
    
    // when
    [self.dataDisplayManager updateTableViewModelWithEvents:self.events];
    
    // then
    OCMVerify([mockViewController didUpdateTableViewModel]);
}

- (void)testThatDataDisplayManagerReturnsCorrectNumberOfSections {
    // given
    NSUInteger const kExpectedNumberOfSections = 1;
    
    // when
    [self.dataDisplayManager updateTableViewModelWithEvents:self.events];
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:nil];
    
    NSUInteger actualNumberOfSections = [dataSource numberOfSectionsInTableView:nil];
    
    // then
    XCTAssertEqual(actualNumberOfSections, kExpectedNumberOfSections);
}

- (void)testThatDataDisplayManagerReturnsCorrectNumberOfRows {
    // given
    NSUInteger const kExpectedNumberOfRows = self.events.count;
    NSUInteger actualNumberOfRows = 0;
    
    
    // when
    [self.dataDisplayManager updateTableViewModelWithEvents:self.events];
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:nil];
    
    NSUInteger overallNumberOfSections = [dataSource numberOfSectionsInTableView:nil];
    
    for (int sectionNumber = 0; sectionNumber < overallNumberOfSections; sectionNumber++) {
        actualNumberOfRows += [dataSource tableView:nil numberOfRowsInSection:sectionNumber];
    }
    
    // then
    XCTAssertEqual(kExpectedNumberOfRows, actualNumberOfRows);
}

- (void)testThatDataDisplayManagerReturnsCorrectClassForTableViewCell {
    // given
    NSUInteger expectedNumberOfCellForCorrespondingClass = self.events.count;
    NSUInteger actualNumberOfCellForCorrespondingClass = 0;
    
    // when
    [self.dataDisplayManager updateTableViewModelWithEvents:self.events];
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:nil];
    
    NSUInteger overallNumberOfSections = [dataSource numberOfSectionsInTableView:nil];
    NSUInteger overallNumberOfCells = 0;
    
    for (int sectionNumber = 0; sectionNumber < overallNumberOfSections; sectionNumber++) {
        overallNumberOfCells += [dataSource tableView:nil numberOfRowsInSection:sectionNumber];
    }
    
    for (int i = 0; i < overallNumberOfCells; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        id tableViewCell = [dataSource tableView:nil cellForRowAtIndexPath:indexPath];
        
        if ([tableViewCell isKindOfClass:[FutureEventTableViewCell class]]) {
            actualNumberOfCellForCorrespondingClass++;
        }
        if ([tableViewCell isKindOfClass:[PastEventTableViewCell class]]) {
            actualNumberOfCellForCorrespondingClass++;
        }
    }
    
    // then
    XCTAssertEqual(expectedNumberOfCellForCorrespondingClass, actualNumberOfCellForCorrespondingClass);
}

#pragma mark - Helpers

- (NSArray *)generateEvents {
    NSMutableArray *events = [NSMutableArray array];
    
    for (int i = 0; i < 2; i++) {
        PlainEvent *event = [PlainEvent new];
        [events addObject:event];
    }
    
    return events;
}

@end
