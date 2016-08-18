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

#import "ReportListViewController.h"
#import "ReportListViewOutput.h"
#import "DataDisplayManager.h"
#import "ReportListDataDisplayManager.h"
#import "EventPlainObject.h"

@interface ReportListTableViewControllerTests : XCTestCase

@property (strong, nonatomic) ReportListViewController <ReportListDataDisplayManagerDelegate, UISearchBarDelegate> *viewController;
@property (strong, nonatomic) ReportListDataDisplayManager *mockDataDisplayManager;
@property (strong, nonatomic) id <ReportListViewOutput> mockOutput;
@property (strong, nonatomic) UITableView *mockTableView;

@end

@implementation ReportListTableViewControllerTests

- (void)setUp {
    [super setUp];
    
    self.viewController = [ReportListViewController<ReportListDataDisplayManagerDelegate, UISearchBarDelegate> new];
    self.mockDataDisplayManager = OCMClassMock([ReportListDataDisplayManager class]);
    self.mockOutput = OCMProtocolMock(@protocol(ReportListViewOutput));
    self.mockTableView = OCMClassMock([UITableView class]);
    
    self.viewController.dataDisplayManager = self.mockDataDisplayManager;
    self.viewController.output = self.mockOutput;
    self.viewController.reportsTableView = self.mockTableView;
}

- (void)tearDown {
    self.viewController = nil;
    [(id)self.mockDataDisplayManager stopMocking];
    self.mockDataDisplayManager = nil;
    [(id)self.mockOutput stopMocking];
    self.mockOutput = nil;
    [(id)self.mockTableView stopMocking];
    self.mockTableView = nil;

    [super tearDown];
}

#pragma mark - Lifecycle

- (void)testSuccessViewDidLoad {
    // given
    
    // when
    [self.viewController viewDidLoad];
    
    // then
    OCMVerify([self.mockOutput setupView]);
}

#pragma mark - ReportListViewInput

- (void)testSuccessSetupViewWithSuggests {
    // given
    NSArray *suggests = @[];
    
    id dataSource = OCMProtocolMock(@protocol(UITableViewDataSource));
    id delegate = OCMProtocolMock(@protocol(UITableViewDelegate));
    
    OCMStub([self.mockDataDisplayManager dataSourceForTableView:self.mockTableView withSuggests:OCMOCK_ANY]).andReturn(dataSource);
    OCMStub([self.mockDataDisplayManager delegateForTableView:self.mockTableView withBaseDelegate:nil]).andReturn(delegate);
    
    // when
    [self.viewController setupViewWithSuggests:suggests];
    
    // then
    OCMVerify([self.mockTableView setDataSource:dataSource]);
    OCMVerify([self.mockTableView setDelegate:delegate]);
}

#pragma mark - ReportListDataDisplayManagerDelegate

- (void)testSuccessDidTapCellWithEvent {
    // given
    EventPlainObject *event = [EventPlainObject new];
    
    // when
    [self.viewController didTapCellWithEvent:event];
    
    // then
    OCMVerify([self.mockOutput didTriggerTapCellWithEvent:event]);
}

- (void)testSuccessSearchTextChange {
    // given
    UISearchBar *searchBar = [UISearchBar new];
    NSString *searchString = @"search string";
    // when
    [self.viewController searchBar:searchBar textDidChange:searchString];

    // then
    OCMVerify([self.mockOutput didChangeSearchBarWithSearchTerm:searchString]);
}

- (void)testSuccessTapSuggest {
    // given
    NSString *testSuggest = @"text";
    
    // when
    [self.viewController didTapSuggestButtonWithSuggest:testSuggest];
    
    // then
    OCMVerify([self.mockOutput didTapSuggestWithText:testSuggest]);
}

@end
