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

#import "ReportsSearchViewController.h"
#import "ReportsSearchViewAnimator.h"
#import "UIColor+ConferencesPallete.h"

@class LecturePlainObject;
@class SpeakerPlainObject;

static NSInteger kDefaultEstimatedHeight = 116;

@implementation ReportsSearchViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.reportsListSearchTableView.estimatedRowHeight = kDefaultEstimatedHeight;
    self.reportsListSearchTableView.separatorColor = [UIColor LJ_separatorColor];
}

#pragma mark - ReportsSearchViewInput

- (void)showClearPlaceholder {
    [self.animatorReportsSearchView showClearPlaceholderWithAnimation];
}

- (void)closeSearchView {
    [self.animatorReportsSearchView closeSearchViewWithAnimation];
}

- (void)setupView {
    [self.reportsListSearchTableView setTableFooterView:[UIView new]];
    
    self.animatorReportsSearchView.delegate = self;
    self.dataDisplayManager.delegate = self;
    
    self.reportsListSearchTableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.reportsListSearchTableView];
    self.reportsListSearchTableView.delegate = [self.dataDisplayManager delegateForTableView:self.reportsListSearchTableView withBaseDelegate:nil];
}

- (void)updateViewWithObjectList:(NSArray *)foundObjects searchText:(NSString *)searchText{
    [self.clearPlaceholderView setHidden:YES];
    
    BOOL isEmptyReports = ([foundObjects count] == 0);
    BOOL willHideEmptyPlaceHolder = !isEmptyReports;
    BOOL willHideReportsList = isEmptyReports;
    
    [self.reportsListSearchTableView setHidden:willHideReportsList];
    [self.emptyPlaceholderView setHidden:willHideEmptyPlaceHolder];
    
    searchText = [searchText lowercaseString];
    [self.dataDisplayManager updateTableViewModelWithObjects:foundObjects searchText:searchText];
}

#pragma mark - ReportsSearchDataDisplayManagerDelegate methods

- (void)didUpdateTableViewModel {
    self.reportsListSearchTableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.reportsListSearchTableView];
    [self.reportsListSearchTableView reloadData];
}

- (void)didTapCellWithEvent:(EventPlainObject *)event {
    [self.output didTriggerTapCellWithEvent:event];
}

- (void)didTapCellWithLecture:(LecturePlainObject *)lecture {
    [self.output didTriggerTapCellWithLecture:lecture];
}

- (void)didTapCellWithSpeaker:(SpeakerPlainObject *)speaker {
    [self.output didTriggerTapCellWithSpeaker:speaker];
}

#pragma mark - ReportsSearchViewAnimatorOutput

- (void)didTapClearPlaceholderView {
    [self.output didTapClearPlaceholderView];
}
#pragma mark - Gesture Recognizer

- (IBAction)handleTapClearPlaceholder:(id)sender {
    [self closeSearchView];
}

@end
