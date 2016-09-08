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
#import <RamblerTyphoonUtils/AssemblyCollector.h>

#import "TyphoonAppDelegate.h"

@interface TyphoonAppDelegateTests : XCTestCase

@property (nonatomic, strong) TyphoonAppDelegate *appDelegate;

@end

@implementation TyphoonAppDelegateTests

- (void)setUp {
    [super setUp];
    
    self.appDelegate = [TyphoonAppDelegate new];
}

- (void)tearDown {
    self.appDelegate = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCollectsInitialAssemblies {
    // given
    NSArray *testArray = @[@"1"];
    
    id mockCollector = OCMClassMock([RamblerInitialAssemblyCollector class]);
    OCMStub([mockCollector new]).andReturn(mockCollector);
    OCMStub([mockCollector collectInitialAssemblyClasses]).andReturn(testArray);
    
    // when
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    id result = [self.appDelegate performSelector:@selector(initialAssemblies)];
#pragma clang diagnostic pop
    
    // then
    XCTAssertEqualObjects(result, testArray);
    [mockCollector stopMocking];
    mockCollector = nil;
}

@end
