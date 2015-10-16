//
//  RequestConfiguratorsAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 15/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerMcFlurry/Testing.h>

#import "RequestConfiguratorsAssembly.h"
#import "RequestConfiguratorsFactory.h"
#import "RESTRequestConfigurator.h"

@interface RequestConfiguratorsAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) RequestConfiguratorsAssembly *assembly;

@end

@implementation RequestConfiguratorsAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [RequestConfiguratorsAssembly new];
    [self.assembly activate];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesRESTRequestConfigurator {
    // given
    Class targetClass = [RESTRequestConfigurator class];
    NSArray *dependencies = @[
                              RamblerSelector(baseURL),
                              RamblerSelector(apiPath)
                              ];
    // when
    id result = [self.assembly requestConfiguratorWithType:@(RequestConfigurationRESTType)];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

@end
