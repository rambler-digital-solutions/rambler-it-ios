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

#import "EventGalleryViewController.h"

#import "EventGalleryViewOutput.h"
#import "EventGalleryBackgroundColorAnimator.h"
#import "EventGalleryCollectionViewFlowLayout.h"

#import "EventPlainObject.h"
#import "TechPlainObject.h"

#import "Extensions/UIViewController+CDObserver/UIViewController+CDObserver.h"
#import "UIColor+Hex.h"

@implementation EventGalleryViewController

#pragma mark - Lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
    [self cd_startObserveProtocol:@protocol(EventGalleryMoreEventsCollectionViewCellActionProtocol)];
	[self.output didTriggerViewReadyEvent];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - <EventGalleryViewInput>

- (void)setupInitialState {
    self.navigationController.navigationBar.hidden = YES;
    
    self.backgroundColorAnimator.view = self.view;
    self.backgroundColorAnimator.additionalView = self.backgroundAdditionalView;
    self.backgroundColorAnimator.scrollView = self.collectionView;
    
    self.collectionView.collectionViewLayout = self.collectionViewFlowLayout;
    self.collectionView.dataSource = [self.dataDisplayManager dataSourceForCollectionView:self.collectionView];
    self.collectionView.delegate = [self.dataDisplayManager delegateForCollectionView:self.collectionView];
}

- (void)updateStateWithFutureEvents:(NSArray<EventPlainObject *> *)events {
    EventPlainObject *firstEvent = [events firstObject];
    self.backgroundAdditionalView.backgroundColor = [UIColor colorFromHexString:firstEvent.tech.color];
    
    [self.dataDisplayManager updateDataSourceWithEvents:events];
    [self.collectionView reloadData];
}

#pragma mark - <EventGalleryMoreEventsCollectionViewCellActionProtocol>

- (void)didTapReportsButton {
    [self.output didTriggerReportsButtonTapEvent];
}

#pragma mark - <EventGalleryDataDisplayManagerDelegate>

- (void)didTapEventAnnouncementCellWithEvent:(EventPlainObject *)event {
    [self.output didTriggerEventTapEventWithObject:event];
}

@end
