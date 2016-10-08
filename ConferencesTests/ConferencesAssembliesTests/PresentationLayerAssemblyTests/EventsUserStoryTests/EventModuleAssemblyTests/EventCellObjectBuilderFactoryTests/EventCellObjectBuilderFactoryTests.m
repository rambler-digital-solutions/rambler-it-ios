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

#import "EventCellObjectBuilderFactory.h"
#import "EventCellObjectBuilderFactory_Testable.h"
#import "CurrentEventCellObjectBuilder.h"
#import "FutureEventCellObjectBuilder.h"
#import "PastEventCellObjectBuilder.h"
#import "RamblerInitialAssemblyCollector+Activate.h"

#import "HTTPMethodConstants.h"

@interface EventCellObjectBuilderFactoryTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) EventCellObjectBuilderFactory *factory;

@end

@implementation EventCellObjectBuilderFactoryTests

- (void)setUp {
    [super setUp];
    Class class = [EventCellObjectBuilderFactory class];
    self.factory = [RamblerInitialAssemblyCollector rds_activateAssemblyWithClass:class];
}

- (void)tearDown {
    self.factory = nil;

    [super tearDown];
}

- (void)testThatAssemblyCreatesCurrentEventCellObjectBuilder {
    // given
    Class targetClass = [CurrentEventCellObjectBuilder class];
    NSArray *dependencies = @[
                              RamblerSelector(dateFormatter)
                              ];
    // when
    id result = [self.factory currentEventCellObjectBuilder];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

- (void)testThatAssemblyCreatesFutureEventCellObjectBuilder {
    // given
    Class targetClass = [FutureEventCellObjectBuilder class];
    NSArray *dependencies = @[
                              RamblerSelector(dateFormatter)
                              ];
    // when
    id result = [self.factory futureEventCellObjectBuilder];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPastEventCellObjectBuilder {
    // given
    Class targetClass = [PastEventCellObjectBuilder class];
    NSArray *dependencies = @[
                              RamblerSelector(dateFormatter)
                              ];
    // when
    id result = [self.factory pastEventCellObjectBuilder];
    
    // then
    RamblerTyphoonAssemblyTestsTypeDescriptor *descriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:result withDescriptor:descriptor dependencies:dependencies];
}

@end
