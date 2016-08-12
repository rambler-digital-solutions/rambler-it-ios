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

#import "AnnouncementListTableViewController.h"

#import "EventPlainObject.h"
#import "AnnouncementListViewOutput.h"
#import "DataDisplayManager.h"
#import "NearestAnnouncementTableHeaderView.h"
#import "AnnouncementListAnimator.h"
#import "DateFormatter.h"

static CGFloat const kAnnouncementTableViewEstimatedRowHeight = 44.0f;

@interface AnnouncementListTableViewController() <UITableViewDelegate>

@end

@implementation AnnouncementListTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.output setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark - AnnouncementListViewInput

- (void)setupViewWithEventList:(NSArray *)events {
    self.dataDisplayManager.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = kAnnouncementTableViewEstimatedRowHeight;
    
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView
                                                           withBaseDelegate:self];
    
    [self updateViewWithEventList:events];
}

- (void)updateViewWithEventList:(NSArray *)events {
    EventPlainObject *announce = [events firstObject];
    [self updateTableViewHeaderWithAnnounce:announce
                                     events:events];
    
    NSMutableArray *futureEvents = [events mutableCopy];
    [futureEvents removeObject:announce];
    [self.dataDisplayManager updateTableViewModelWithEvents:futureEvents];
}

#pragma mark - AnnouncementListDataDisplayManagerDelegate

- (void)didUpdateTableViewModel {
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    [self.tableView reloadData];
}

- (void)didTapCellWithEvent:(EventPlainObject *)event {
    [self.output didTriggerTapCellWithEvent:event];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.animator animateWithContentOffset:scrollView.contentOffset];
}

- (void)updateTableViewHeaderWithAnnounce:(EventPlainObject *)announce
                                   events:(NSArray *)events {
    if (!announce) {
        return;
    }
    
    NSString *dateString = [self.dateFormatter obtainDateWithDayMonthFormat:announce.startDate];
    NSString *timeString = [self.dateFormatter obtainDateWithTimeFormat:announce.startDate];
    [self.nearestAnnouncementHeaderView updateWithEvent:announce
                                                   date:dateString
                                                   time:timeString];
    
    self.tableView.tableHeaderView = nil;
    CGRect frame = [self calculateFrameForHeaderView:events.count];
    self.nearestAnnouncementHeaderView.frame = frame;
    self.tableView.tableHeaderView = self.nearestAnnouncementHeaderView;
}

- (CGRect)calculateFrameForHeaderView:(NSInteger)eventCount {
    CGRect frame = self.nearestAnnouncementHeaderView.frame;
    frame.size.width = self.view.bounds.size.width;
    frame.size = [self.nearestAnnouncementHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGFloat fullSizeHeight = self.tableView.bounds.size.height - self.tabBarController.tabBar.bounds.size.height;
    frame.size.height = eventCount > 1 ? frame.size.height : fullSizeHeight;
    
    return frame;
}

@end