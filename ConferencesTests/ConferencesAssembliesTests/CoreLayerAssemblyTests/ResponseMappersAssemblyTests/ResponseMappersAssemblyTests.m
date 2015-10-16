//
//  ResponseMappersAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 16/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerMcFlurry/Testing.h>

#import "ResponseMappersAssembly.h"
#import "ResponseMappersAssembly_Testable.h"
#import "ResponseMappersFactory.h"

#import "ResultsResponseObjectFormatter.h"
#import "SingleResponseObjectFormatter.h"
#import "ManagedObjectMappingProvider.h"
#import "ManagedObjectMapper.h"

@interface ResponseMappersAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) ResponseMappersAssembly *assembly;

@end

@implementation ResponseMappersAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [ResponseMappersAssembly new];
    [self.assembly activate];
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
