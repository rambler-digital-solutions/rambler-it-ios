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

#import "UberRidesAppDelegate.h"

#import <UberRides/UberRides.h>

@interface UberRidesAppDelegateTests : XCTestCase

@property (nonatomic, strong) UberRidesAppDelegate *appDelegate;
@property (nonatomic, strong) id mockUberConfiguration;

@end

@implementation UberRidesAppDelegateTests

- (void)setUp {
    [super setUp];
    
    self.appDelegate = [UberRidesAppDelegate new];
    
    self.mockUberConfiguration = OCMClassMock([UBSDKConfiguration class]);
    OCMStub([self.mockUberConfiguration shared]).andReturn(self.mockUberConfiguration);
}

- (void)tearDown {
    self.appDelegate = nil;
    
    [self.mockUberConfiguration stopMocking];
    self.mockUberConfiguration = nil;
    
    [super tearDown];
}

- (void)testThatAppDelegateCallSetSandboxEnabled {
    // given
    
    // when
    [self.appDelegate application:OCMOCK_ANY didFinishLaunchingWithOptions:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockUberConfiguration setIsSandbox:NO]);
}

- (void)testThatAppDelegateCallSetFallbackEnabled {
    // given
    
    // when
    [self.appDelegate application:OCMOCK_ANY didFinishLaunchingWithOptions:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockUberConfiguration setUseFallback:NO]);
}

@end
