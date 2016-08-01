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

#import "ReportsSearchDataDisplayManager.h"
#import "ReportEventTableViewCell.h"
#import "EventPlainObject.h"
#import "ReportsSearchViewController.h"

typedef NS_ENUM(NSUInteger, TableViewSectionIndex){
    ReportsSection = 0
};

@interface ReportsSearchDataDisplayManagerTests : XCTestCase

@property (strong, nonatomic) ReportsSearchDataDisplayManager *dataDisplayManager;
@property (strong, nonatomic) NSArray *events;

@end

@implementation ReportsSearchDataDisplayManagerTests

- (void)setUp {
    [super setUp];
    
    self.dataDisplayManager = [ReportsSearchDataDisplayManager new];
    self.events = @[[EventPlainObject new], [EventPlainObject new], [EventPlainObject new]];
}

- (void)tearDown {
    self.dataDisplayManager = nil;
    self.events = nil;
    
    [super tearDown];
}

- (void)testThatDataDisplayManagerReturnsTableViewDataSource{
    // given
    
    // when
    [self.dataDisplayManager updateTableViewModelWithObjects:self.events searchText:@""];
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:nil];
    
    // then
    XCTAssertNotNil(dataSource);
}

- (void)testSuccessUpdateTableViewModelWithEvents {
    // given
    id mockViewController = OCMClassMock([ReportsSearchViewController class]);
    self.dataDisplayManager.delegate = mockViewController;
    
    // when
    [self.dataDisplayManager updateTableViewModelWithObjects:self.events searchText:@""];
    
    // then
    OCMVerify([mockViewController didUpdateTableViewModel]);
}

- (void)testThatDataDisplayManagerReturnsCorrectNumberOfSections {
    // given
    NSUInteger const kExpectedNumberOfSections = 1;
    NSUInteger actualNumberOfSections = 0;
    
    // when
    [self.dataDisplayManager updateTableViewModelWithObjects:self.events searchText:@""];
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:nil];
    
    actualNumberOfSections = [dataSource numberOfSectionsInTableView:nil];
    
    // then
    XCTAssertEqual(actualNumberOfSections, kExpectedNumberOfSections);
}

- (void)testThatDataDisplayManagerReturnsCorrectNumberOfRows {
    // given
    NSUInteger headerTableView = 1;
    NSUInteger footerTableView = 1;
    
    NSUInteger const kExpectedNumberOfRows = self.events.count + headerTableView + footerTableView;
    NSUInteger actualNumberOfRows = 0;
    
    // when
    [self.dataDisplayManager updateTableViewModelWithObjects:self.events searchText:@""];
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:nil];
    actualNumberOfRows = [dataSource tableView:nil numberOfRowsInSection:ReportsSection];
    
    // then
    XCTAssertEqual(kExpectedNumberOfRows, actualNumberOfRows);
}

- (void)testThatDataDisplayManagerReturnsCorrectClassForTableViewCell {
    // given
    NSUInteger expectedNumberOfCellForCorrespondingClass = self.events.count;
    NSUInteger actualNumberOfCellForCorrespondingClass = 0;
    
    // when
    [self.dataDisplayManager updateTableViewModelWithObjects:self.events searchText:@""];
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:nil];
    
    NSUInteger numberOfRows = [dataSource tableView:nil numberOfRowsInSection:ReportsSection];
    
    for (int i = 0; i < numberOfRows; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:ReportsSection];
        UITableViewCell *cell = [dataSource tableView:nil cellForRowAtIndexPath:indexPath];
        
        if ([cell isKindOfClass:[ReportEventTableViewCell class]]) {
            actualNumberOfCellForCorrespondingClass++;
        }
    }
    
    // then
    XCTAssertEqual(expectedNumberOfCellForCorrespondingClass, actualNumberOfCellForCorrespondingClass);
}

@end
