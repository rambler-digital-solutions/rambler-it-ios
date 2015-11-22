//
//  ReportListView.m
//  Conferences
//
//  Created by Karpushin Artem on 08/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "ReportListTableViewController.h"
#import "ReportListViewOutput.h"
#import "DataDisplayManager.h"
#import "ReportListDataDisplayManager.h"

@interface ReportListTableViewController() <ReportListDataDisplayManagerDelegate>

@end

@implementation ReportListTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.output setupView];
}

#pragma mark - ReportListViewInput

- (void)setupViewWithEventList:(NSArray *)events {
    [self.tableView setTableFooterView:[UIView new]];
    
    [self.dataDisplayManager updateTableViewModelWithEvents:events];
    self.dataDisplayManager.delegate = self;
    
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView withBaseDelegate:nil];
}

- (void)updateViewWithEventList:(NSArray *)events {
    [self.dataDisplayManager updateTableViewModelWithEvents:events];
}

#pragma mark - ReportListDataDisplayManagerDelegate methods

- (void)didUpdateTableViewModel {
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    [self.tableView reloadData];
}

- (void)didTapCellWithEvent:(PlainEvent *)event {
    [self.output didTriggerTapCellWithEvent:event];
}

@end