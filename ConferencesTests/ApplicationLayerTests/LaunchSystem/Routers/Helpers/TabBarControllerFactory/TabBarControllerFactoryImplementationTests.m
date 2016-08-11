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

#import "TabBarControllerFactoryImplementation.h"

@interface TabBarControllerFactoryImplementationTests : XCTestCase

@property (nonatomic, strong) TabBarControllerFactoryImplementation *factory;
@property (nonatomic, strong) id mockStoryboard;

@end

@implementation TabBarControllerFactoryImplementationTests

- (void)setUp {
    [super setUp];
    
    self.mockStoryboard = OCMClassMock([UIStoryboard class]);
    self.factory = [TabBarControllerFactoryImplementation factoryWithStoryboard:self.mockStoryboard];
}

- (void)tearDown {
    self.factory = nil;
    
    [self.mockStoryboard stopMocking];
    self.mockStoryboard = nil;
    
    [super tearDown];
}

- (void)testThatFactoryCreatesTabBarController {
    // given
    id mockController = [NSObject new];
    OCMStub([self.mockStoryboard instantiateInitialViewController]).andReturn(mockController);
    
    // when
    id result = [self.factory obtainPreconfiguredTabBarController];
    
    // then
    XCTAssertEqualObjects(result, mockController);
}

@end
