//
//  OperationFactoriesAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 15/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "OperationFactoriesAssembly_Testable.h"
#import "OperationFactoriesAssembly.h"

#import "EventOperationFactory.h"
#import "NetworkCompoundOperationBuilder.h"
#import "OperationChainer.h"

@interface OperationFactoriesAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) OperationFactoriesAssembly *assembly;

@end

@implementation OperationFactoriesAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [OperationFactoriesAssembly new];
    [self.assembly activate];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssmeblyCreatesEventOperationFactory {
    // given
    Class targetClass = [EventOperationFactory class];
    NSArray *dependencies = @[
                              RamblerSelector(networkOperationBuilder)
                              ];
    
    // when
    id result = [self.assembly eventOperationFactory];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesOperationChainer {
    // given
    Class targetClass = [OperationChainer class];
    
    // when
    id result = [self.assembly operationChainer];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

@end
