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

#import "EventViewController.h"
#import "EventViewOutput.h"
#import "EventDataDisplayManager.h"
#import "DataDisplayManager.h"
#import "EventTableViewCellActionProtocol.h"
#import "PlainEvent.h"
#import "EventHeaderModuleInput.h"

#import <CrutchKit/Proxying/Extensions/UIViewController+CDObserver/UIViewController+CDObserver.h>

@interface EventViewController() <EventTableViewCellActionProtocol>

@end

@implementation EventViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
    [self cd_startObserveProtocol:@protocol(EventTableViewCellActionProtocol)];
	[self.output setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - EventViewInput

- (void)configureViewWithEvent:(PlainEvent *)event {
    [self configureNavigationBarWithColor:event.backgroundColor];
    // refactor
    [self setScrollViewColor:event.backgroundColor];
    
    [self.dataDisplayManager configureDataDisplayManagerWithEvent:event];
    
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView withBaseDelegate:nil];
    
    [self setupHeaderViewWithEvent:event];
}

#pragma mark - EventTableViewCellActionProtocol

- (void)didTapSignUpButton:(UIButton *)button {
    [self.output didTriggerSignUpButtonTappedEvent];
}

- (void)didTapSaveToCalendarButton:(UIButton *)button {
    [self.output didTriggerSaveToCalendarButtonTappedEvent];
}

- (void)didTapReadMoreEventDescriptionButton:(UIButton *)button {
    [self.output didTriggerReadMoreEventDescriptionButtonTappedEvent];
}

- (void)didTapReadMoreLectureDescriptionButton:(UIButton *)button {
    [self.output didTriggerReadMoreLectureDescriptionButtonTappedEvent];
}

- (void)didTapCurrentTranslationButton:(UIButton *)button {
    [self.output didTriggerCurrentTranslationButtonTapEvent];
}

#pragma mark - Private methods

- (void)setupHeaderViewWithEvent:(PlainEvent *)event {
    [self.headerView configureModuleWithEvent:event];
    
    CGFloat tableViewHeaderHeight = self.headerView.frame.size.height;
    UIView *tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  self.view.frame.size.width,
                                                                  tableViewHeaderHeight)];
    tableViewHeaderView.backgroundColor = [UIColor clearColor];
    [self.tableView setTableHeaderView:tableViewHeaderView];
}

- (void)configureNavigationBarWithColor:(UIColor *)color {
    [self.navigationController.navigationBar setBarTintColor:color];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
}

- (void)setScrollViewColor:(UIColor *)color {
    [[UIScrollView appearance] setBackgroundColor:color];
}

@end