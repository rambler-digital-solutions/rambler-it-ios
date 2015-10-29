//
//  EventListView.m
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "EventListTableViewController.h"
#import "EventListViewOutput.h"
#import "DataDisplayManager.h"
#import "EventListDataDisplayManager.h"

@interface EventListTableViewController() <UITableViewDelegate>

@end

@implementation EventListTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.output setupView];
    
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView withBaseDelegate:self];
    [self.tableView setTableFooterView:[UIView new]];
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

#pragma mark - EventListViewInput

@end