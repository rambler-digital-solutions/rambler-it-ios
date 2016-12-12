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

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "RamblerLocationPresenter.h"

#import "RamblerLocationViewInput.h"
#import "RamblerLocationInteractorInput.h"
#import "RamblerLocationRouterInput.h"
#import "MockObjectsFactory.h"

#import <UberRides/UberRides.h>

@interface RamblerLocationPresenterTests : XCTestCase

@property (nonatomic, strong) RamblerLocationPresenter *presenter;

@property (nonatomic, strong) id mockView;
@property (nonatomic, strong) id mockInteractor;
@property (nonatomic, strong) id mockRouter;

@end

@implementation RamblerLocationPresenterTests

- (void)setUp {
    [super setUp];
    
    self.presenter = [RamblerLocationPresenter new];
    
    self.mockView = OCMProtocolMock(@protocol(RamblerLocationViewInput));
    self.mockInteractor = OCMProtocolMock(@protocol(RamblerLocationInteractorInput));
    self.mockRouter = OCMProtocolMock(@protocol(RamblerLocationRouterInput));
    
    self.presenter.view = self.mockView;
    self.presenter.interactor = self.mockInteractor;
    self.presenter.router = self.mockRouter;
}

- (void)tearDown {
    self.presenter = nil;
    
    self.mockRouter = nil;
    self.mockInteractor = nil;
    self.mockView = nil;
    
    [super tearDown];
}

- (void)testThatPresenterHandlesViewReadyEvent {
    // given
    id object = [MockObjectsFactory generateRandomNumber];
    
    NSArray *testDirections = @[@"1", @"2"];
    OCMStub([self.mockInteractor obtainDirections]).andReturn(testDirections);
    OCMStub([self.mockInteractor obtainDefaultParameters]).andReturn(object);
    
    // when
    [self.presenter didTriggerViewReadyEvent];
    
    // then
    OCMVerify([self.mockView setupViewWithDirections:testDirections]);
    OCMVerify([self.mockView setupUberRidesDefaultConfigWithParameters:object]);
    OCMVerify([self.mockView updateRideInformation]);
    OCMVerify([self.mockInteractor performRideInfoForUserCurrentLocationIfPossible]);
}

- (void)testThatPresenterHandlesShareButtonTapEvent {
    // given
    NSURL *testUrl = [NSURL URLWithString:@"rambler.ru"];
    OCMStub([self.mockInteractor obtainRamblerLocationUrl]).andReturn(testUrl);
    
    // when
    [self.presenter didTriggerShareButtonTapEvent];
    
    // then
    OCMVerify([self.mockRouter openMapsWithUrl:testUrl]);
}

- (void)testThatPresenterUberModalViewControllerWillDismiss {
    // when
    [self.presenter uberModalViewControllerWillDismiss];
    
    // then
    OCMVerify([self.mockView updateRideInformation]);
}

- (void)testThatPresenterRideParametersDidLoad {
    // given
    id object = [MockObjectsFactory generateRandomNumber];
    
    // when
    [self.presenter rideParametersDidLoad:object];
    
    // then
    OCMVerify([self.mockView updateRideRequestButtonParameters:object]);
    OCMVerify([self.mockView updateRideInformation]);
}

- (void)testThatPresenterRideRequestViewControllerDidReceiveError {
    // given
    id vc = [MockObjectsFactory generateRandomViewController];
    NSError *error = [NSError new];
    
    // when
    [self.presenter rideRequestViewController:vc didReceiveError:error];
    
    // then
    OCMVerify([self.mockView dismissRideRequestViewController:vc]);
    OCMVerify([self.mockView displayAlertWithTitle:OCMOCK_ANY andMessage:OCMOCK_ANY]);
}

@end
