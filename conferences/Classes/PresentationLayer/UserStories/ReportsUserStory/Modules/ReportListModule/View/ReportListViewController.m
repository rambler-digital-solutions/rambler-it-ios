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

#import "ReportListViewController.h"
#import "ReportListViewOutput.h"
#import "DataDisplayManager.h"
#import "ReportListDataDisplayManager.h"
#import <RamblerSegues/RamblerSegues.h>
#import "UINavigationBar+States.h"

static const NSInteger kDefaultEstimatedHeight = 116;

@interface ReportListViewController() <ReportListDataDisplayManagerDelegate, RamblerEmbedSegueViewContainer>

@end

@implementation ReportListViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.output setupView];
    self.reportsTableView.estimatedRowHeight = kDefaultEstimatedHeight;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupViewInitialState];
}

#pragma mark - ReportListViewInput

- (void)setupViewWithEventList:(NSArray *)events {
    [self.reportsTableView setTableFooterView:[UIView new]];
    
    [self.dataDisplayManager updateTableViewModelWithEvents:events];
    self.dataDisplayManager.delegate = self;
    
    self.reportsTableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.reportsTableView];
    self.reportsTableView.delegate = [self.dataDisplayManager delegateForTableView:self.reportsTableView withBaseDelegate:nil];
}

- (void)setupViewInitialState {
    [self.navigationController.navigationBar rcf_becomeTransparent];
    self.navigationController.navigationBar.hidden = YES;
    self.reportsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)updateViewWithEventList:(NSArray *)events {
    [self.dataDisplayManager updateTableViewModelWithEvents:events];
}

- (void)hideSearchModuleView {
    [self.searchBar resignFirstResponder];
    [self.searchEmbedContainer setHidden:YES];
}

#pragma mark - ReportListDataDisplayManagerDelegate methods

- (void)didUpdateTableViewModel {
    self.reportsTableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.reportsTableView];
    [self.reportsTableView reloadData];
}

- (void)didTapCellWithEvent:(EventPlainObject *)event {
    [self.output didTriggerTapCellWithEvent:event];
}

#pragma mark - SearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.searchEmbedContainer setHidden:NO];
    [self.searchBar setShowsCancelButton:YES animated:YES];
    [self.output didChangeSearchBarWithSearchTerm:searchBar.text];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.output didChangeSearchBarWithSearchTerm:searchText];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.output didTapSearchBarCancelButton];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [self hideCancelButtonSearchBar];
    return YES;
}
- (UIView *)viewForEmbedIdentifier:(NSString *)embedIdentifier {
    return self.searchEmbedContainer;
}

#pragma mark - Helpers

- (void)hideCancelButtonSearchBar {
    [self.searchBar setShowsCancelButton:NO animated:YES];
}

@end