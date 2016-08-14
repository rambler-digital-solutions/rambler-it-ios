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

#import "AnnouncementGalleryViewController.h"

#import "AnnouncementGalleryViewOutput.h"
#import "AnnouncementGalleryBackgroundColorAnimator.h"
#import "AnnouncementGalleryCollectionViewFlowLayout.h"

#import "EventPlainObject.h"
#import "TechPlainObject.h"
#import "UIColor+Hex.h"

@implementation AnnouncementGalleryViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - <AnnouncementGalleryViewInput>

- (void)setupInitialState {
    self.navigationController.navigationBar.hidden = YES;
    
    self.backgroundColorAnimator.view = self.view;
    self.backgroundColorAnimator.additionalView = self.backgroundAdditionalView;
    
    self.collectionView.collectionViewLayout = self.collectionViewFlowLayout;
}

- (void)updateStateWithFutureEvents:(NSArray<EventPlainObject *> *)events {
    self.view.backgroundColor = [UIColor colorFromHexString:events.firstObject.tech.color];
    
    self.collectionView.dataSource = [self.dataDisplayManager dataSourceForCollectionView:self.collectionView
                                                                               withEvents:events];
    self.collectionView.delegate = [self.dataDisplayManager delegateForCollectionView:self.collectionView];
    
    [self.collectionView reloadData];
}

#pragma mark - <AnnouncementGalleryDataDisplayManagerDelegate>

- (void)didTapEventAnnouncementCellWithEvent:(EventPlainObject *)event {
    [self.output didTriggerAnnouncementTapEventWithObject:event];
}

@end
