//
//  EventView.m
//  Conferences
//
//  Created by Karpushin Artem on 01/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "EventViewController.h"
#import "EventViewOutput.h"
#import "EventDataDisplayManager.h"
#import "DataDisplayManager.h"

static CGFloat kMinHedareHeight = 64.0;

@interface EventViewController() 

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpaceToTableViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewToHeaderConstraint;

@end

@implementation EventViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.output setupView];
}

#pragma mark - EventViewInput

- (void)configureViewWithEvent:(PlainEvent *)event {
    [((EventDataDisplayManager *) self.dataDisplayManager) configureDataDisplayManagerWithEvent:event];
    
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView withBaseDelegate:nil];
}

@end