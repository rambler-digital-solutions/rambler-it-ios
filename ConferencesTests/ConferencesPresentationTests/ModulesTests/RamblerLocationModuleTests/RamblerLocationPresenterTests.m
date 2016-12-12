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
<<<<<<< HEAD
#import "MockObjectsFactory.h"

#import <UberRides/UberRides.h>
=======
#import "RamblerLocationStateStorage.h"
>>>>>>> develop

@interface RamblerLocationPresenterTests : XCTestCase

@property (nonatomic, strong) RamblerLocationPresenter *presenter;

@property (nonatomic, strong) id mockView;
@property (nonatomic, strong) id mockInteractor;
@property (nonatomic, strong) id mockRouter;
@property (nonatomic, strong) id mockStateStorage;

@end

@implementation RamblerLocationPresenterTests

- (void)setUp {
    [super setUp];
    
    self.presenter = [RamblerLocationPresenter new];
    
    self.mockView = OCMProtocolMock(@protocol(RamblerLocationViewInput));
    self.mockInteractor = OCMProtocolMock(@protocol(RamblerLocationInteractorInput));
    self.mockRouter = OCMProtocolMock(@protocol(RamblerLocationRouterInput));
    self.mockStateStorage = OCMClassMock([RamblerLocationStateStorage class]);
    
    self.presenter.view = self.mockView;
    self.presenter.interactor = self.mockInteractor;
    self.presenter.router = self.mockRouter;
    self.presenter.stateStorage = self.mockStateStorage;
}

- (void)tearDown {
    self.presenter = nil;
    
    self.mockRouter = nil;
    self.mockInteractor = nil;
    self.mockView = nil;
    
    [self.mockStateStorage stopMocking];
    self.mockStateStorage = nil;
    
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

- (void)testThatPresenterRegistersUserActivityOnViewReadyEvent {
    // given
    id mockActivity = [NSObject new];
    OCMStub([self.mockInteractor registerUserActivity]).andReturn(mockActivity);
    
    // when
    [self.presenter didTriggerViewReadyEvent];
    
    // then
    OCMVerify([self.mockInteractor registerUserActivity]);
    OCMVerify([self.mockStateStorage setActivity:mockActivity]);
}

- (void)testThatPresenterUnregistersUserActivityOnViewWillDisappearEvent {
    // given
    id mockActivity = [NSObject new];
    OCMStub([self.mockStateStorage activity]).andReturn(mockActivity);
    
    // when
    [self.presenter didTriggerViewWillDisappearEvent];
    
    // then
    OCMVerify([self.mockInteractor unregisterUserActivity:mockActivity]);
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
    id viewController = [MockObjectsFactory generateRandomViewController];
    NSError *error = [NSError new];
    
    // when
    [self.presenter rideRequestViewController:viewController didReceiveError:error];
    
    // then
    OCMVerify([self.mockView dismissRideRequestViewController:viewController]);
    OCMVerify([self.mockView displayAlertWithTitle:OCMOCK_ANY andMessage:OCMOCK_ANY]);
}

@end
