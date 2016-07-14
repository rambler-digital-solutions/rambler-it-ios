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

#import "ResponseMappersAssembly.h"
#import "ResponseMappersAssembly_Testable.h"
#import "ResponseMappersFactory.h"

#import "ResultsResponseObjectFormatter.h"
#import "SingleResponseObjectFormatter.h"
#import "ManagedObjectMappingProvider.h"
#import "ManagedObjectMapper.h"
#import "RamblerInitialAssemblyCollector+Activate.h"

@interface ResponseMappersAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) ResponseMappersAssembly *assembly;

@end

@implementation ResponseMappersAssemblyTests

- (void)setUp {
    [super setUp];
    
    Class class = [ResponseMappersAssembly class];
    self.assembly = [RamblerInitialAssemblyCollector activateAssemblyWithClass:class];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesResultsObjectFormatter {
    // given
    Class targetClass = [ResultsResponseObjectFormatter class];
    
    // when
    id result = [self.assembly resultsObjectFormatter];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

- (void)testThatAssemblyCreatesSingleObjectFormatter {
    // given
    Class targetClass = [SingleResponseObjectFormatter class];
    
    // when
    id result = [self.assembly singleObjectFormatter];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

- (void)testThatAssemblyCreatesMappingProvider {
    // given
    Class targetClass = [ManagedObjectMappingProvider class];
    
    // when
    id result = [self.assembly mappingProvider];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

- (void)testThatAssemblyCreatesMapperWithResponseMappingResultsType {
    // given
    Class targetClass = [ManagedObjectMapper class];
    NSArray *dependencies = @[
                              RamblerSelector(provider),
                              RamblerSelector(responseFormatter)
                              ];
    // when
    id result = [self.assembly mapperWithType:@(ResponseMappingResultsType)];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesMapperWithResponseMappingSingleType {
    // given
    Class targetClass = [ManagedObjectMapper class];
    NSArray *dependencies = @[
                              RamblerSelector(provider),
                              RamblerSelector(responseFormatter)
                              ];
    // when
    id result = [self.assembly mapperWithType:@(ResponseMappingSingleType)];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

@end
