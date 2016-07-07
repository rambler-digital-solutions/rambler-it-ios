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

#import "RamblerLocationServiceImplementation.h"
#import "DirectionObject.h"
#import "ResourceMapper.h"
#import "ResourceClient.h"

@interface RamblerLocationServiceTests : XCTestCase

@property (nonatomic, strong) RamblerLocationServiceImplementation *service;
@property (nonatomic, strong) id mockClient;
@property (nonatomic, strong) id mockMapper;

@end

@implementation RamblerLocationServiceTests

- (void)setUp {
    [super setUp];
    
    self.service = [RamblerLocationServiceImplementation new];
    
    self.mockClient = OCMProtocolMock(@protocol(ResourceClient));
    self.mockMapper = OCMProtocolMock(@protocol(ResourceMapper));
    
    self.service.client = self.mockClient;
    self.service.mapper = self.mockMapper;
}

- (void)tearDown {
    self.service = nil;
    
    self.mockClient = nil;
    
    [super tearDown];
}

- (void)testThatServiceReturnsMappedData {
    // given
    NSDictionary *testResource = @{
                                   @"test" : @"test"
                                   };
    NSArray *testMappingResult = @[[DirectionObject new], [DirectionObject new]];
    OCMStub([self.mockClient loadResourceWithName:OCMOCK_ANY type:OCMOCK_ANY]).andReturn(testResource);
    OCMStub([self.mockMapper mapResource:testResource]).andReturn(testMappingResult);
    
    // when
    NSArray *result = [self.service obtainDirections];
    
    // then
    OCMVerify([self.mockMapper mapResource:testResource]);
    XCTAssertEqualObjects(result, testMappingResult);
}

- (void)testThatServiceReturnsCoordinate {
    // given
    
    
    // when
    CLLocationCoordinate2D result = [self.service obtainRamblerCoordinates];
    
    // then
    XCTAssertTrue(result.latitude != NSNotFound);
    XCTAssertTrue(result.longitude != NSNotFound);
}

@end
