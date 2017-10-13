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
#import <MapKit/MapKit.h>

#import "RamblerLocationInteractor.h"

#import "RamblerLocationInteractorOutput.h"
#import "MockObjectsFactory.h"
#import "RamblerLocationService.h"
#import "MapLinkBuilder.h"
#import "LocationService.h"

#import <UberRides/UberRides.h>

@interface RamblerLocationInteractorTests : XCTestCase

@property (nonatomic, strong) RamblerLocationInteractor *interactor;

@property (nonatomic, strong) id mockOutput;
@property (nonatomic, strong) id mockRamblerLocationService;
@property (nonatomic, strong) id mockMapLinkBuilder;
@property (nonatomic, strong) id mockBuilder;
@property (nonatomic, strong) id mockLocationService;
@property (nonatomic, strong) id mockRidesClient;
@property (nonatomic, strong) id mockProduct;

@end

@implementation RamblerLocationInteractorTests

- (void)setUp {
    [super setUp];
    
    self.interactor = [RamblerLocationInteractor new];
    
    self.mockOutput = OCMProtocolMock(@protocol(RamblerLocationInteractorOutput));
    self.mockRamblerLocationService = OCMProtocolMock(@protocol(RamblerLocationService));
    self.mockMapLinkBuilder = OCMProtocolMock(@protocol(MapLinkBuilder));
    self.mockBuilder = OCMClassMock([UBSDKRideParametersBuilder class]);
    self.mockLocationService = OCMProtocolMock(@protocol(LocationService));
    self.mockRidesClient = OCMClassMock([UBSDKRidesClient class]);
    self.mockProduct = OCMClassMock([UBSDKProduct class]);
    
    self.interactor.output = self.mockOutput;
    self.interactor.ramblerLocationService = self.mockRamblerLocationService;
    self.interactor.mapLinkBuilder = self.mockMapLinkBuilder;
    self.interactor.builder = self.mockBuilder;
    self.interactor.locationService = self.mockLocationService;
    self.interactor.ridesClient = self.mockRidesClient;
}

- (void)tearDown {
    self.interactor = nil;
    
    self.mockOutput = nil;
    self.mockRamblerLocationService = nil;
    self.mockMapLinkBuilder = nil;
    self.mockLocationService = nil;
    
    [self.mockBuilder stopMocking];
    self.mockBuilder = nil;
    
    [self.mockRidesClient stopMocking];
    self.mockRidesClient = nil;
    
    [self.mockProduct stopMocking];
    self.mockProduct = nil;
    
    [super tearDown];
}

- (void)testThatInteractorObtainsDirections {
    // given
    NSArray *testDirections = @[@"1", @"2"];
    OCMStub([self.mockRamblerLocationService obtainDirections]).andReturn(testDirections);
    
    // when
    NSArray *result = [self.interactor obtainDirections];
    
    // then
    XCTAssertEqualObjects(result, testDirections);
}

- (void)testThatInteractorObtainsRamblerLocationUrl {
    // given
    CLLocationCoordinate2D testCoordinates = CLLocationCoordinate2DMake(10, 20);
    OCMStub([self.mockRamblerLocationService obtainRamblerCoordinates]).andReturn(testCoordinates);
    
    NSURL *testUrl = [NSURL URLWithString:@"rambler.ru"];
    OCMStub([self.mockMapLinkBuilder buildUrlWithCoordinates:testCoordinates]).andReturn(testUrl);
    
    // when
    NSURL *result = [self.interactor obtainRamblerLocationUrl];
    
    // then
    XCTAssertEqualObjects(result, testUrl);
}

- (void)testThatInteractorPerformRideInfoForUserCurrentLocationIfPossible {
    //given
    
    // when
    [self.interactor performRideInfoForUserCurrentLocationIfPossible];
    
    // then
    OCMVerify([self.mockLocationService obtainUserLocation]);
}

- (void)testThatInteractorObtainDefaultParameters {
    // given
    id randomObject = [MockObjectsFactory generateRandomNumber];
    OCMStub([self.mockBuilder build]).andReturn(randomObject);
    
    // when
    id object = [self.interactor obtainDefaultParameters];
    
    // then
    XCTAssertEqualObjects(randomObject, object);
}

- (void)testThatInteractorLocationServiceDidUpdateLocation {
    // given
    CLLocation *location = [CLLocation new];
    
    // when
    [self.interactor locationService:self.mockLocationService didUpdateLocation:location];
    
    // then
    OCMVerify([self.mockBuilder setPickupLocation:location]);
    OCMVerify([self.mockRidesClient fetchProductsWithPickupLocation:location completion:OCMOCK_ANY]);
}

- (void)testThatInteractorSetProductIdAfterFetchCheapestProduct {
    // given
    CLLocation *location = [CLLocation new];
    id productId = [MockObjectsFactory generateRandomNumber];
    
    [self prepareFetchCheapestProductTestWithLocation:location productId:productId];
    
    // when
    [self.interactor locationService:self.mockLocationService didUpdateLocation:location];
    
    // then
    OCMVerify([self.mockBuilder setProductID:productId]);
}

- (void)testThatInteractorSetBuilderAfterFetchCheapestProduct {
    // given
    CLLocation *location = [CLLocation new];
    id productId = [MockObjectsFactory generateRandomNumber];
    
    [self prepareFetchCheapestProductTestWithLocation:location productId:productId];
    
    // when
    [self.interactor locationService:self.mockLocationService didUpdateLocation:location];
    
    // then
    XCTAssertEqualObjects(self.interactor.builder, self.mockBuilder);
}

- (void)testThatInteractorRideParametersDidLoadAfterFetchCheapestProduct {
    // given
    CLLocation *location = [CLLocation new];
    id productId = [MockObjectsFactory generateRandomNumber];
    id params = [MockObjectsFactory generateRandomNumber];
    
    [self prepareFetchCheapestProductTestWithLocation:location productId:productId];
    OCMStub([self.mockBuilder build]).andReturn(params);
    
    // when
    [self.interactor locationService:self.mockLocationService didUpdateLocation:location];
    
    // then
    OCMVerify([self.mockOutput rideParametersDidLoad:params]);
}

- (void)testThatInteractorRegistersUserActivity {
    // given
    
    
    // when
    NSUserActivity *result = [self.interactor registerUserActivity];
    
    // then
    XCTAssertNotNil(result);
    XCTAssertNotNil(result.title);
    XCTAssertNotNil(result.mapItem);
}

- (void)testThatInteractorUnregistersUserActivity {
    // given
    id mockActivity = OCMClassMock([NSUserActivity class]);
    
    // when
    [self.interactor unregisterUserActivity:mockActivity];
    
    // then
    OCMVerify([mockActivity resignCurrent]);
    [mockActivity stopMocking];
}

#pragma mark - Private methods

- (void)prepareFetchCheapestProductTestWithLocation:(CLLocation *)location productId:(id)productId {
    id arg = [OCMArg invokeBlockWithArgs:self.mockProduct, OCMOCK_ANY, nil];
    
    OCMStub([self.mockRidesClient fetchProductsWithPickupLocation:location completion:arg]);
    OCMStub([self.mockProduct productID]).andReturn(productId);
    OCMStub([self.mockBuilder setProductID:productId]).andReturn(self.mockBuilder);
}

@end
