//
//  NetworkClientsAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 15/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "NetworkClientsAssembly.h"
#import "NetworkClientsFactory.h"

#import "CommonNetworkClient.h"

@interface NetworkClientsAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) NetworkClientsAssembly *assembly;

@end

@implementation NetworkClientsAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [NetworkClientsAssembly new];
    [self.assembly activate];
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
