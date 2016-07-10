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

#import "RamblerLocationInteractor.h"

#import "RamblerLocationInteractorOutput.h"
#import "RamblerLocationService.h"
#import "MapLinkBuilder.h"

@interface RamblerLocationInteractorTests : XCTestCase

@property (nonatomic, strong) RamblerLocationInteractor *interactor;

@property (nonatomic, strong) id mockOutput;
@property (nonatomic, strong) id mockLocationService;
@property (nonatomic, strong) id mockMapLinkBuilder;

@end

@implementation RamblerLocationInteractorTests

- (void)setUp {
    [super setUp];
    
    self.interactor = [RamblerLocationInteractor new];
    
    self.mockOutput = OCMProtocolMock(@protocol(RamblerLocationInteractorOutput));
    self.mockLocationService = OCMProtocolMock(@protocol(RamblerLocationService));
    self.mockMapLinkBuilder = OCMProtocolMock(@protocol(MapLinkBuilder));
    
    self.interactor.output = self.mockOutput;
    self.interactor.locationService = self.mockLocationService;
    self.interactor.mapLinkBuilder = self.mockMapLinkBuilder;
}

- (void)tearDown {
    self.interactor = nil;
    
    self.mockOutput = nil;
    self.mockLocationService = nil;
    self.mockMapLinkBuilder = nil;
    
    [super tearDown];
}

- (void)testThatInteractorObtainsDirections {
    // given
    NSArray *testDirections = @[@"1", @"2"];
    OCMStub([self.mockLocationService obtainDirections]).andReturn(testDirections);
    
    // when
    NSArray *result = [self.interactor obtainDirections];
    
    // then
    XCTAssertEqualObjects(result, testDirections);
}

- (void)testThatInteractorObtainsRamblerLocationUrl {
    // given
    CLLocationCoordinate2D testCoordinates = CLLocationCoordinate2DMake(10, 20);
    OCMStub([self.mockLocationService obtainRamblerCoordinates]).andReturn(testCoordinates);
    
    NSURL *testUrl = [NSURL URLWithString:@"rambler.ru"];
    OCMStub([self.mockMapLinkBuilder buildUrlWithCoordinates:testCoordinates]).andReturn(testUrl);
    
    // when
    NSURL *result = [self.interactor obtainRamblerLocationUrl];
    
    // then
    XCTAssertEqualObjects(result, testUrl);
}

@end
