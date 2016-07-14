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
#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "NetworkClientsAssembly.h"
#import "NetworkClientsFactory.h"

#import "CommonNetworkClient.h"
#import "RamblerInitialAssemblyCollector+Activate.h"

@interface NetworkClientsAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) NetworkClientsAssembly *assembly;

@end

@implementation NetworkClientsAssemblyTests

- (void)setUp {
    [super setUp];
    
    Class class = [NetworkClientsAssembly class];
    self.assembly = [RamblerInitialAssemblyCollector activateAssemblyWithClass:class];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

// вынес session в интерфейс
- (void)testThatAssemblyCreatesCommonNetworkClient {
    // given
    Class targetClass = [CommonNetworkClient class];
    NSArray *dependencies = @[
                              RamblerSelector(session)
                              ];
    
    // when
    id result = [self.assembly commonNetworkClient];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

@end
