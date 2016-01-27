//
//  SpeakerInfoView.m
//  Conferences
//
//  Created by Karpushin Artem on 16/01/16.
//  Copyright 2016 Rambler. All rights reserved.
//

#import "SpeakerInfoViewController.h"
#import "SpeakerInfoViewOutput.h"
#import "SpeakerInfoDataDisplayManager.h"
#import "SpeakerShortInfoModuleInput.h"

@interface SpeakerInfoViewController()

@end

@implementation SpeakerInfoViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.output setupView];
}

#pragma mark - SpeakerInfoViewInput

- (void)setupViewWithSpeaker:(SpeakerPlainObject *)speaker {
    [self.dataDisplayManager configureDataDisplayManagerWithSpeaker:speaker];
    
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView withBaseDelegate:nil];
    [self setupHeaderViewWithSpeaker:speaker];
}

#pragma mark - Private methods

- (void)setupHeaderViewWithSpeaker:(SpeakerPlainObject *)speaker {
    [self.speakerShortInfoView configureModuleWithSpeaker:speaker andViewSize:SpeakerShortInfoViewBigSize];
    
    CGFloat tableViewHeaderHeight = self.speakerShortInfoView.frame.size.height;
    UIView *tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                           0,
                                                                           self.view.frame.size.width,
                                                                           tableViewHeaderHeight)];
    tableViewHeaderView.backgroundColor = [UIColor clearColor];
    [self.tableView setTableHeaderView:tableViewHeaderView];
}

@end