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

#import "EventListDataDisplayManager.h"
#import "EventListTableViewCellObject.h"
#import "EventListTableViewCell.h"
#import "EventListCellObjectBuilder.h"

#import <OCMock/OCMock.h>
#import "EventListTableViewController.h"

typedef NS_ENUM(NSUInteger, TableViewSectionIndex){
    EventsSection = 0
};

@interface AnnouncementListDataDisplayManagerTests : XCTestCase

@property (nonatomic, strong) EventListDataDisplayManager *dataDisplayManager;
@property (nonatomic, strong) id mockCellObjectBuilder;
@property (nonatomic, strong) NSArray *events;

@end

@implementation AnnouncementListDataDisplayManagerTests

- (void)setUp {
    [super setUp];
    
    self.dataDisplayManager = [EventListDataDisplayManager new];
    
    self.mockCellObjectBuilder = OCMClassMock([EventListCellObjectBuilder class]);
    self.dataDisplayManager.cellObjectBuilder = self.mockCellObjectBuilder;
    
    self.events = [self generateViewModels];
    OCMStub([self.mockCellObjectBuilder buildCellObjectsWithEvents:OCMOCK_ANY]).andReturn(self.events);
}

- (void)tearDown {
    self.dataDisplayManager = nil;
    self.events = nil;
    
    [self.mockCellObjectBuilder stopMocking];
    self.mockCellObjectBuilder = nil;
    
    [super tearDown];
}

- (void)testThatDataDisplayManagerReturnsTableViewDataSource {
    // given
    
    // when
    [self.dataDisplayManager updateTableViewModelWithEvents:self.events];
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:nil];
    
    // then
    XCTAssertNotNil(dataSource);
}

- (void)testThatDataDisplayManagerReturnsCorrectNumberOfSections {
    // given
    NSUInteger const kExpectedNumberOfSections = 1;
    NSUInteger actualNumberOfSections = 0;
    UITableView *tableView = [UITableView new];

    [self.dataDisplayManager updateTableViewModelWithEvents:self.events];
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:tableView];
    
    // when
     actualNumberOfSections = [dataSource numberOfSectionsInTableView:tableView];
    
    // then
    XCTAssertEqual(actualNumberOfSections, kExpectedNumberOfSections);
}

- (void)testThatDataDisplayManagerReturnsCorrectNumberOfRows {
    // given
    NSUInteger const kExpectedNumberOfRows = self.events.count;
    NSUInteger actualNumberOfRows = 0;
    UITableView *tableView = [UITableView new];
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:tableView];
    [self.dataDisplayManager updateTableViewModelWithEvents:self.events];

    // when
    actualNumberOfRows = [dataSource tableView:tableView numberOfRowsInSection:EventsSection];

    // then
    XCTAssertEqual(kExpectedNumberOfRows, actualNumberOfRows);
}

#pragma mark - Вспомогательные методы

- (NSArray *)generateViewModels {
    NSMutableArray *viewModels = [NSMutableArray new];
    for (NSInteger index = 0; index < 3; index++) {
        [viewModels addObject:[EventListTableViewCellObject new]];
    }
    
    return viewModels;
}

@end
