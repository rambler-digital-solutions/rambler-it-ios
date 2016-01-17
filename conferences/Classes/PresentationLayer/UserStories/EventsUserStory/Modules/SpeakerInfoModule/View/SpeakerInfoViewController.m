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
}

@end