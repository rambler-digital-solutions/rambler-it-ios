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

#import "SearchViewController.h"

#import "SearchViewOutput.h"
#import "DataDisplayManager.h"
#import "SearchDataDisplayManager.h"

#import "Extensions/UIViewController+CDObserver/UIViewController+CDObserver.h"
#import "UINavigationBar+States.h"

#import <RamblerSegues/RamblerSegues.h>

@interface SearchViewController() <RamblerEmbedSegueViewContainer>

@end

@implementation SearchViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [self cd_startObserveProtocol:@protocol(SearchSuggestTableViewCellActionProtocol)];
	[self.output setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupViewInitialState];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - ReportListViewInput

- (void)setupViewWithSuggests:(NSArray *)suggests {
    [self.reportsTableView setTableFooterView:[UIView new]];

    self.reportsTableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.reportsTableView withSuggests:suggests];
    self.reportsTableView.delegate = [self.dataDisplayManager delegateForTableView:self.reportsTableView withBaseDelegate:nil];
}

- (void)setupViewInitialState {
    [self.navigationController.navigationBar rcf_becomeDefault];
}

- (void)hideSearchModuleView {
    [self.searchBar resignFirstResponder];
    [self.searchEmbedContainer setHidden:YES];
}

- (void)showSearchModuleView {
    [self.searchEmbedContainer setHidden:NO];
    [self.searchBar setShowsCancelButton:YES animated:YES];
}

- (void)updateSearchBarWithText:(NSString *)text {
    self.searchBar.text = text;
}

#pragma mark - SearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
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

#pragma mark - <SearchSuggestTableViewCellActionProtocol>

- (void)didTapSuggestButtonWithSuggest:(NSString *)suggest {
    [self.output didTapSuggestWithText:suggest];
}

#pragma mark - Helpers

- (void)hideCancelButtonSearchBar {
    [self.searchBar setShowsCancelButton:NO animated:YES];
}

@end