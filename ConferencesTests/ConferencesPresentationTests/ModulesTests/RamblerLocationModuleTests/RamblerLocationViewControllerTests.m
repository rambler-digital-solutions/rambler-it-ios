//
//  RamblerLocationViewControllerTests.m
//  Conferences
//
//  Created by s.sarkisyan on 07.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "RamblerLocationViewController.h"
#import "TestableObject.h"

#import "RamblerLocationViewOutput.h"
#import "RamblerLocationDataDisplayManager.h"
#import "UberRidesFactory.h"

#import <UberRides/UberRides.h>
#import <PureLayout/PureLayout.h>

@interface RamblerLocationViewController ()

@property (nonatomic, readwrite, strong) UBSDKRideRequestButton *rideRequestButton;

@end

@interface RamblerLocationViewControllerTests : XCTestCase

@property (nonatomic, strong) RamblerLocationViewController *viewController;
@property (nonatomic, strong) id mockOutput;
@property (nonatomic, strong) RamblerLocationDataDisplayManager *mockDataDisplayManager;
@property (nonatomic, strong) UBSDKRideRequestViewRequestingBehavior *mockRequestBehavior;
@property (nonatomic, strong) UBSDKRideRequestButton *mockRideRequestButton;
@property (nonatomic, strong) UICollectionView *mockCollectionView;
@property (nonatomic, strong) UIView *mockRideButtonContainerView;
@property (nonatomic, strong) UberRidesFactory *mockUberRidesFactory;

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
    self.mockDataDisplayManager = nil;
    self.mockRequestBehavior = nil;
    self.mockRideRequestButton = nil;
    self.mockCollectionView = nil;
    self.mockRideButtonContainerView = nil;
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
    NSInteger orinetation = [self.viewController supportedInterfaceOrientations];
    
    // then
    XCTAssertEqual(expectedOrientation, orinetation);
}

- (void)testThatViewControllerUpdateRideInformation {
    // when
    [self.viewController updateRideInformation];
    
    // then
    OCMVerify([self.mockRideRequestButton loadRideInformation]);
}

- (void)testThatViewControllerUpdateRideRequestButtonParameters {
    // given
    id params = @5;
    
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
    id modalRideRequestObject = [TestableObject new];
    id rideRequestObject = [TestableObject new];
    id params = @5;
    
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
    id dataSource = @5;
    id delegate = @6;
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
