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
#import "NearestEventTableViewCell.h"
#import "EventListTableViewCell.h"

#import <OCMock/OCMock.h>
#import "EventListTableViewController.h"

typedef NS_ENUM(NSUInteger, TableViewSectionIndex){
    EventsSection = 0
};

@interface EventListDataDisplayManagerTests : XCTestCase

@property (strong, nonatomic) EventListDataDisplayManager *dataDisplayManager;
@property (strong, nonatomic) NSArray *events;

@end

@implementation EventListDataDisplayManagerTests

- (void)setUp {
    [super setUp];
    
    self.dataDisplayManager = [EventListDataDisplayManager new];
    self.events = @[[PlainEvent new], [PlainEvent new], [PlainEvent new]];
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
    NSUInteger actualNumberOfSections = 0;
    
    // when
    [self.dataDisplayManager updateTableViewModelWithEvents:self.events];
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:nil];
    
     actualNumberOfSections = [dataSource numberOfSectionsInTableView:nil];
    
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
    actualNumberOfRows = [dataSource tableView:nil numberOfRowsInSection:EventsSection];

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
    
    NSUInteger numberOfRows = [dataSource tableView:nil numberOfRowsInSection:EventsSection];
    
    for (int i = 0; i < numberOfRows; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:EventsSection];
        UITableViewCell *cell = [dataSource tableView:nil cellForRowAtIndexPath:indexPath];
        
        if ([cell isKindOfClass:[NearestEventTableViewCell class]]) {
            actualNumberOfCellForCorrespondingClass++;
        }
        if ([cell isKindOfClass:[EventListTableViewCell class]]) {
            actualNumberOfCellForCorrespondingClass++;
        }
    }
    
    // then
    XCTAssertEqual(expectedNumberOfCellForCorrespondingClass, actualNumberOfCellForCorrespondingClass);
}

@end
