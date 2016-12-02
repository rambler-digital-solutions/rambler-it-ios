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

#import "SearchViewController.h"
#import "SearchViewOutput.h"
#import "DataDisplayManager.h"
#import "SearchDataDisplayManager.h"
#import "EventPlainObject.h"

@protocol OutputProtocolTest <SearchViewOutput, SearchModuleInput>
@end

@interface SearchViewControllerTests : XCTestCase

@property (strong, nonatomic) SearchViewController *viewController;
@property (strong, nonatomic) SearchDataDisplayManager *mockDataDisplayManager;
@property (strong, nonatomic) id<OutputProtocolTest> mockOutput;
@property (strong, nonatomic) UITableView *mockTableView;

@end

@implementation SearchViewControllerTests

- (void)setUp {
    [super setUp];
    
    self.viewController = [SearchViewController new];
    self.mockDataDisplayManager = OCMClassMock([SearchDataDisplayManager class]);
    self.mockOutput = OCMProtocolMock(@protocol(OutputProtocolTest));
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

- (void)testSuccessSearchTextChange {
    // given
    UISearchBar *searchBar = [UISearchBar new];
    NSString *searchString = @"search string";
    // when
    [(id<UISearchBarDelegate>)self.viewController searchBar:searchBar textDidChange:searchString];

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

- (void)testThatControllerConfigureModuleCorrectly {
    // given
    NSString *searchString = @"text";

    // when
    [self.viewController configureSearchModuleWithSearchTerm:searchString];
    
    // then
    OCMVerify([self.mockOutput configureSearchModuleWithSearchTerm:searchString]);
}

@end
