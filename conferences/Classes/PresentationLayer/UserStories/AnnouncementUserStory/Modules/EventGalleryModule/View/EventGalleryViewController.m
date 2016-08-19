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
#import <FLAnimatedImage/FLAnimatedImage.h>

static NSString *const kLoadingAnimationImageName = @"loading%lu";
static NSString *const kErrorImageName = @"ampersand-error.gif";
static NSUInteger const kLoadingAnimationFrameCount = 9;
static CGFloat const kLoadingAnimationDuration = 1.8f;

@implementation EventGalleryViewController

#pragma mark - Lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
    [self cd_startObserveProtocol:@protocol(EventGalleryMoreEventsCollectionViewCellActionProtocol)];
	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - <EventGalleryViewInput>

- (void)setupInitialState {
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

- (void)showGalleryState {
    self.collectionView.hidden = NO;
    self.backgroundAdditionalView.hidden = NO;
    
    self.loadingImageView.hidden = YES;
    [self.loadingImageView stopAnimating];
    
    self.errorView.hidden = YES;
}

- (void)showLoadingState {
    self.collectionView.hidden = YES;
    self.backgroundAdditionalView.hidden = YES;
    
    self.loadingImageView.animationImages = [self obtainLoadingAnimationImages];
    self.loadingImageView.animationDuration = kLoadingAnimationDuration;
    [self.loadingImageView startAnimating];
    
    self.errorView.hidden = YES;
}

- (void)showErrorState {
    self.collectionView.hidden = YES;
    self.backgroundAdditionalView.hidden = YES;
    
    self.loadingImageView.hidden = YES;
    [self.loadingImageView stopAnimating];
    
    self.errorView.hidden = NO;
    NSData *imageData = [self obtainErrorAnimatedImageData];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:imageData];
    self.errorImageView.animatedImage = image;
}

#pragma mark - <EventGalleryMoreEventsCollectionViewCellActionProtocol>

- (void)didTapMoreEventsButton {
    [self.output didTriggerMoreEventsButtonTapEvent];
}

#pragma mark - <EventGalleryDataDisplayManagerDelegate>

- (void)didTapEventAnnouncementCellWithEvent:(EventPlainObject *)event {
    [self.output didTriggerEventTapEventWithObject:event];
}

#pragma mark - Private methods

- (NSArray *)obtainLoadingAnimationImages {
    static NSMutableArray *mutableImages;
    if (mutableImages) {
        return [mutableImages copy];
    }
    
    mutableImages = [NSMutableArray new];
    for (NSUInteger i = 1; i < kLoadingAnimationFrameCount; i++) {
        NSString *imageName = [NSString stringWithFormat:kLoadingAnimationImageName, i];
        UIImage *image = [UIImage imageNamed:imageName];
        [mutableImages addObject:image];
    }
    return [mutableImages copy];
}

- (NSData *)obtainErrorAnimatedImageData {
    static NSData *imageData;
    if (imageData) {
        return imageData;
    }
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:kErrorImageName
                                                          ofType:nil];
    imageData = [NSData dataWithContentsOfFile:imagePath];
    return imageData;
}

@end
