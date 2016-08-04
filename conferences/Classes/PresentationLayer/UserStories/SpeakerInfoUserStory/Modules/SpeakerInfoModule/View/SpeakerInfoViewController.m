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
#import "UINavigationBar+States.h"

static CGFloat TableViewEstimatedRowHeight = 44.0f;

@interface SpeakerInfoViewController()

@end

@implementation SpeakerInfoViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    [self.navigationController.navigationBar becomeTransparent];
	[self.output setupView];
}

#pragma mark - SpeakerInfoViewInput

- (void)setupViewWithSpeaker:(SpeakerPlainObject *)speaker {
    [self.dataDisplayManager configureDataDisplayManagerWithSpeaker:speaker];
    
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView withBaseDelegate:nil];
    self.tableView.estimatedRowHeight = TableViewEstimatedRowHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self setupHeaderViewWithSpeaker:speaker];
}

#pragma mark - Private methods

- (void)setupHeaderViewWithSpeaker:(SpeakerPlainObject *)speaker {
    [self.speakerShortInfoView configureModuleWithSpeaker:speaker
                                              andViewSize:SpeakerShortInfoViewBigSize];
    
    self.tableView.tableHeaderView = nil;
    CGRect frame = [self calculateFrameForHeaderView];
    self.speakerShortInfoView.frame = frame;
    self.tableView.tableHeaderView = self.speakerShortInfoView;
}

- (CGRect)calculateFrameForHeaderView {
    CGRect frame = self.speakerShortInfoView.frame;
    frame.size.width = self.view.bounds.size.width;
    frame.size = [self.speakerShortInfoView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return frame;
}


@end