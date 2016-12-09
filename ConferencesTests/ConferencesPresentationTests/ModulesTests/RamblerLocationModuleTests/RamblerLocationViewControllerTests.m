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

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "RamblerLocationViewController.h"
#import "TestableObjectWithDelegate.h"

#import "RamblerLocationViewOutput.h"
#import "RamblerLocationDataDisplayManager.h"
#import "UberRidesFactory.h"
#import "MockObjectsFactory.h"

#import <UberRides/UberRides.h>
#import <PureLayout/PureLayout.h>

@interface RamblerLocationViewController ()

@property (nonatomic, readwrite, strong) UBSDKRideRequestButton *rideRequestButton;

@end

@interface RamblerLocationViewControllerTests : XCTestCase

@property (nonatomic, strong) RamblerLocationViewController *viewController;
@property (nonatomic, strong) id mockOutput;
@property (nonatomic, strong) id mockDataDisplayManager;
@property (nonatomic, strong) id mockRequestBehavior;
@property (nonatomic, strong) id mockRideRequestButton;
@property (nonatomic, strong) id mockCollectionView;
@property (nonatomic, strong) id mockRideButtonContainerView;
@property (nonatomic, strong) id mockUberRidesFactory;

@end

@implementation RamblerLocationViewControllerTests

- (void)setUp {
    [super setUp];
    
    self.viewController = [RamblerLocationViewController new];
    
    self.mockOutput = OCMProtocolMock(@protocol(RamblerLocationViewOutput));
    self.mockDataDisplayManager = OCMClassMock([RamblerLocationDataDisplayManager class]);
    self.mockRequestBehavior = OCMClassMock([UBSDKRideRequestViewRequestingBehavior class]);
    self.mockRideRequestButton = OCMClassMock([UBSDKRideRequestButton class]);
    self.mockCollectionView = OCMClassMock([UICollectionView class]);
    self.mockRideButtonContainerView = OCMClassMock([UIView class]);
    self.mockUberRidesFactory = OCMClassMock([UberRidesFactory class]);
    
    self.viewController.output = self.mockOutput;
    self.viewController.dataDisplayManager = self.mockDataDisplayManager;
    self.viewController.requestBehavior = self.mockRequestBehavior;
    self.viewController.rideRequestButton = self.mockRideRequestButton;
    self.viewController.collectionView = self.mockCollectionView;
    self.viewController.rideButtonContainerView = self.mockRideButtonContainerView;
    self.viewController.uberRidesFactory = self.mockUberRidesFactory;
}

- (void)tearDown {
    self.viewController = nil;
    
    self.mockOutput = nil;
    
    [self.mockDataDisplayManager stopMocking];
    self.mockDataDisplayManager = nil;
    
    [self.mockRequestBehavior stopMocking];
    self.mockRequestBehavior = nil;
    
    [self.mockRideRequestButton stopMocking];
    self.mockRideRequestButton = nil;
    
    [self.mockCollectionView stopMocking];
    self.mockCollectionView = nil;
    
    [self.mockRideButtonContainerView stopMocking];
    self.mockRideButtonContainerView = nil;
    
    [self.mockUberRidesFactory stopMocking];
    self.mockUberRidesFactory = nil;
    
    [super tearDown];
}

- (void)testThatViewControllerViewDidLoad {
    // when
    [self.viewController viewDidLoad];
    
    // then
    OCMVerify([self.mockOutput didTriggerViewReadyEvent]);
}

- (void)testThatViewControllerSupportedInterfaceOrientations {
    // given
    NSInteger expectedOrientation = UIInterfaceOrientationMaskPortrait;
    
    // when
    NSInteger orientation = [self.viewController supportedInterfaceOrientations];
    
    // then
    XCTAssertEqual(expectedOrientation, orientation);
}

- (void)testThatViewControllerUpdateRideInformation {
    // when
    [self.viewController updateRideInformation];
    
    // then
    OCMVerify([self.mockRideRequestButton loadRideInformation]);
}

- (void)testThatViewControllerUpdateRideRequestButtonParameters {
    // given
    id params = [MockObjectsFactory generateRandomNumber];
    
    // when
    [self.viewController updateRideRequestButtonParameters:params];
    
    // then
    OCMVerify([self.mockRideRequestButton setRideParameters:params]);
}

- (void)testThatViewControllerDidTapShareButton {
    // when
    [self.viewController didTapShareButton:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockOutput didTriggerShareButtonTapEvent]);
}

- (void)testThatViewControllerModalViewControllerWillDismiss {
    // when
    [self.viewController modalViewControllerWillDismiss:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockOutput uberModalViewControllerWillDismiss]);
}

- (void)testThatViewControllerSetupUberRidesDefaultConfigWithParameters {
    // given
    id modalRideRequestObject = [TestableObjectWithDelegate new];
    id rideRequestObject = [TestableObjectWithDelegate new];
    id params = [MockObjectsFactory generateRandomNumber];
    
    OCMStub([self.mockRequestBehavior modalRideRequestViewController]).andReturn(modalRideRequestObject);
    OCMStub([self.mockUberRidesFactory createRideRequestButtonWithParameters:params requestingBehavior:self.mockRequestBehavior]).andReturn(rideRequestObject);
    
    // when
    [self.viewController setupUberRidesDefaultConfigWithParameters:params];
    
    // then
    OCMVerify([modalRideRequestObject setDelegate:self.viewController]);
    OCMVerify([self.mockRideButtonContainerView addSubview:rideRequestObject]);
}

- (void)testThatViewControllerAddRideRequestButtonConstraint {
    // given
    BOOL translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *constraints = @[@1, @2];
    OCMStub([self.mockRideRequestButton autoCenterInSuperview]).andReturn(constraints);
    
    // when
    [self.viewController addRideRequestButtonConstraint];
    
    // then
    OCMVerify([self.mockRideRequestButton setTranslatesAutoresizingMaskIntoConstraints:translatesAutoresizingMaskIntoConstraints]);
    OCMVerify([self.mockRideButtonContainerView addConstraints:constraints]);
}

- (void)testThatViewControllerSetupViewWithDirections {
    // given
    NSArray *testDirections = @[@"1", @"2"];
    id dataSource = [MockObjectsFactory generateRandomNumber];
    id delegate = [MockObjectsFactory generateRandomNumber];
    OCMStub([self.mockDataDisplayManager dataSourceForCollectionView:self.mockCollectionView
                                                      withDirections:testDirections]).andReturn(dataSource);
    OCMStub([self.mockDataDisplayManager delegateForCollectionView:self.mockCollectionView]).andReturn(delegate);
    
    // when
    [self.viewController setupViewWithDirections:testDirections];
    
    // then
    OCMVerify([self.mockCollectionView setDataSource:dataSource]);
    OCMVerify([self.mockCollectionView setDelegate:delegate]);
    OCMVerify([self.mockCollectionView reloadData]);
}

@end
