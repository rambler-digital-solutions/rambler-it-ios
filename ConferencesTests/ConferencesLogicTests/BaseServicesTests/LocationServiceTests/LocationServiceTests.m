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

#import "LocationServiceImplementation.h"
#import "LocationServiceDelegate.h"

@interface LocationServiceImplementationTests : XCTestCase

@property (nonatomic, strong) LocationServiceImplementation *locationService;
@property (nonatomic, strong) id<LocationServiceDelegate> mockDelegate;

@property (nonatomic, strong) id mockLocationManager;

@end

@implementation LocationServiceImplementationTests

- (void)setUp {
    [super setUp];
    
    self.mockLocationManager = OCMClassMock([CLLocationManager class]);
    self.mockDelegate = OCMProtocolMock(@protocol(LocationServiceDelegate));
    
    self.locationService = [[LocationServiceImplementation alloc] initWithLocationManager:self.mockLocationManager];
    self.locationService.delegate = self.mockDelegate;
}

- (void)tearDown {
    self.locationService = nil;
    
    self.mockLocationManager = nil;
    self.mockDelegate = nil;
    
    [super tearDown];
}

- (void)testThatLocationServiceObtainUserLocation {
    // when
    [self.locationService obtainUserLocation];
    
    // then
    OCMVerify([self.mockLocationManager requestLocation]);
}

- (void)testThatLocationServiceDidUpdateLocation {
    // when
    CLLocation *location = [CLLocation new];
    [self.locationService locationManager:self.mockLocationManager didUpdateLocations:@[location]];
    
    // then
    OCMVerify([self.mockDelegate locationService:self.locationService didUpdateLocation:location]);
    OCMVerify([self.mockLocationManager stopUpdatingLocation]);
}

@end
