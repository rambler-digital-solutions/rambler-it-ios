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

#import "RamblerLocationViewController.h"
#import "RamblerLocationViewOutput.h"
#import "RamblerLocationDataDisplayManager.h"
#import "UberRidesFactory.h"
#import "LocalizedStrings.h"

#import <PureLayout/PureLayout.h>

@interface RamblerLocationViewController ()

@property (nonatomic, readwrite, strong) UBSDKRideRequestButton *rideRequestButton;

@end

@implementation RamblerLocationViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [self.output didTriggerViewReadyEvent];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - RamblerLocationViewInput

- (void)setupViewWithDirections:(NSArray<DirectionObject *> *)directions {
    id<UICollectionViewDataSource> dataSource = [self.dataDisplayManager dataSourceForCollectionView:self.collectionView
                                                                                      withDirections:directions];
    id<UICollectionViewDelegate> delegate = [self.dataDisplayManager delegateForCollectionView:self.collectionView];
    self.collectionView.dataSource = dataSource;
    self.collectionView.delegate = delegate;
    
    [self.collectionView reloadData];
}

- (void)setupUberRidesDefaultConfigWithParameters:(UBSDKRideParameters *)parameters {
    self.requestBehavior.modalRideRequestViewController.delegate = self;
    self.requestBehavior.modalRideRequestViewController.rideRequestViewController.delegate = self;
    
    self.rideRequestButton = [self.uberRidesFactory createRideRequestButtonWithParameters:parameters
                                                                  requestingBehavior:self.requestBehavior];

    [self.rideButtonContainerView addSubview:self.rideRequestButton];
}

- (void)addRideRequestButtonConstraint {
    self.rideRequestButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray<NSLayoutConstraint *> *constraints = self.rideRequestButton.autoCenterInSuperview;
    [self.rideButtonContainerView addConstraints:constraints];
}

- (void)updateRideInformation {
    [self.rideRequestButton loadRideInformation];
}

- (void)updateRideRequestButtonParameters:(UBSDKRideParameters *)parameters {
    self.rideRequestButton.rideParameters = parameters;
}

- (void)dismissRideRequestViewController:(UBSDKRideRequestViewController *)rideRequestViewController {
    [rideRequestViewController dismissViewControllerAnimated:NO completion:nil];
}

- (void)displayAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *closeAction = [UIAlertAction actionWithTitle:RCLocalize(OKAlertActionTitle)
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alert addAction:closeAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UBSDKRideRequestViewControllerDelegate

- (void)rideRequestViewController:(UBSDKRideRequestViewController *)rideRequestViewController
                  didReceiveError:(NSError *)error {
    [self.output rideRequestViewController:rideRequestViewController didReceiveError:error];
}

#pragma mark - UBSDKModalViewControllerDelegate

- (void)modalViewControllerDidDismiss:(UBSDKModalViewController *)modalViewController {
    //Required for UBSDKModalViewControllerDelegate, thats why we should override this method
}

- (void)modalViewControllerWillDismiss:(UBSDKModalViewController *)modalViewController {
    [self.output uberModalViewControllerWillDismiss];
}

#pragma mark - IBOutlets

- (IBAction)didTapShareButton:(id)sender {
    [self.output didTriggerShareButtonTapEvent];
}

@end
