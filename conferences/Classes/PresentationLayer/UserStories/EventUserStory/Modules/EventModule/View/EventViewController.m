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
#import "EventPlainObject.h"
#import "TechPlainObject.h"
#import "DataDisplayManager.h"
#import "EventTableViewCellActionProtocol.h"
#import "EventPlainObject.h"
#import "EventHeaderModuleInput.h"
#import "LocalizedStrings.h"
#import "UINavigationBar+States.h"
#import "EventViewAnimator.h"
#import "Extensions/UIViewController+CDObserver/UIViewController+CDObserver.h"
#import "UIColor+Hex.h"

@interface EventViewController()

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
    [self setupViewInitialState];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - EventViewInput

- (void)configureViewWithEvent:(EventPlainObject *)event pastEvents:(NSArray *)pastEvents {
    
    self.dataDisplayManager.eventViewAnimator = self.eventViewAnimator;
    self.dataDisplayManager.delegate = self;
    [self.dataDisplayManager configureDataDisplayManagerWithEvent:event pastEvents:pastEvents];
    
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView
                                                           withBaseDelegate:nil];
    
    [self setupHeaderViewWithEvent:event];
}

- (void)displayAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle: UIAlertControllerStyleAlert];

    UIAlertAction *closeAction = [UIAlertAction actionWithTitle:NSLocalizedString(OKAlertActionTitle, nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alert addAction:closeAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - EventTableViewCellActionProtocol

- (void)didTapSignUpButtonWithEvent:(EventPlainObject *)event {
    [self.output didTapSignUpButtonWithEvent:event];
}

- (void)didTapSaveToCalendarButtonWithEvent:(EventPlainObject *)event {
    [self.output didTapSaveToCalendarButtonWithEvent:event];
}

- (void)didSpeakerViewWithSpeakerId:(NSString *)speakerId {
    [self.output didTapSpeakerViewWithSpeakerId:speakerId];
}

#pragma mark - EventDataDisplayManagerDelegate

- (void)didTapLectureInfoCellWithLectureObjectId:(NSString *)lectureObjectId {
    [self.output didTapLectureInfoCellWithLectureObjectIdEvent:lectureObjectId];
}

- (void)didTapEventCellWithEventId:(NSString *)eventId {
    [self.output didTapEventCellWithEventId:eventId];
}

#pragma mark - IBActions

- (IBAction)didTapShareButton:(UIBarButtonItem *)sender {
    [self.output didTapShareButton];
}

#pragma mark - Private methods

- (void)setupViewInitialState {
    [self.navigationController.navigationBar rcf_becomeTransparent];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.hidden = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupHeaderViewWithEvent:(EventPlainObject *)event {
    [self.headerView configureModuleWithEvent:event];
    self.headerBackgroundView.backgroundColor = [UIColor colorFromHexString:event.tech.color];
    CGRect frame = self.headerView.frame;
    frame.size.width = self.view.bounds.size.width;
    frame.size = [self.headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    self.headerView.frame = frame;
    self.tableView.tableHeaderView = self.headerView;
}

@end