// Copyright (c) 2016 RAMBLER&Co
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

#import "LectureViewController.h"
#import "LectureViewOutput.h"
#import "LectureDataDisplayManager.h"
#import "SpeakerPlainObject.h"
#import "LecturePlainObject.h"
#import "SpeakerShortInfoModuleInput.h"

static CGFloat TableViewEstimatedRowHeight = 44.0f;

@interface LectureViewController() <UIGestureRecognizerDelegate>

@end

@implementation LectureViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.output setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupShareButton];
}

#pragma mark - LectureViewInput

- (void)configureViewWithLecture:(LecturePlainObject *)lecture {
    [self.dataDisplayManager configureDataDisplayManagerWithLecture:lecture];
    
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView withBaseDelegate:nil];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = TableViewEstimatedRowHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    SpeakerPlainObject *speaker = lecture.speaker;
    [self setupHeaderViewWithSpeaker:speaker];
}

#pragma mark - Private methods

- (void)setupHeaderViewWithSpeaker:(SpeakerPlainObject *)speaker {
    [self.speakerShortInfoView configureModuleWithSpeaker:speaker andViewSize:SpeakerShortInfoViewDefaultSize];
    
    CGFloat tableViewHeaderHeight = self.speakerShortInfoView.frame.size.height;
    UIView *tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                           0,
                                                                           self.view.frame.size.width,
                                                                           tableViewHeaderHeight)];
    tableViewHeaderView.backgroundColor = [UIColor clearColor];
    [self.tableView setTableHeaderView:tableViewHeaderView];
    
    [self addGestureRecognizerForTableViewHeader:tableViewHeaderView];
}

- (void)addGestureRecognizerForTableViewHeader:(UIView *)headerView {
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(didTapTableViewHeader)];
    gestureRecognizer.delegate = self;
    
    [headerView addGestureRecognizer:gestureRecognizer];
}

- (void)setupShareButton {
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(didTapShareButton)];
    self.navigationItem.rightBarButtonItem = shareButton;
}

#pragma mark - Actions

- (void)didTapTableViewHeader {
    [self.output didTapTableViewHeader];
}

- (void)didTapShareButton {
    [self.output didTapShareButton];
}

@end