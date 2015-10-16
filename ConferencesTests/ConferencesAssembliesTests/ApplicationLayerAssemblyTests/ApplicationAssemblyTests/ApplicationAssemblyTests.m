//
//  ApplicationAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerMcFlurry/Testing.h>

#import "ApplicationAssembly.h"
#import "ApplicationAssembly_Testable.h"
#import "ServiceComponentsAssembly.h"

#import "AppDelegate.h"
#import "ApplicationConfiguratorImplementation.h"
#import "PushNotificationCenterImplementation.h"
#import "ThirdPartiesConfiguratorImplementation.h"

@interface ApplicationAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) ApplicationAssembly *assembly;

@end

@implementation ApplicationAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [ApplicationAssembly new];
    [self.assembly activateWithCollaboratingAssemblies:@[
                                                         [ServiceComponentsAssembly new]
                                                         ]];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesAppDelegate {
    // given
    Class targetClass = [AppDelegate class];
    NSArray *dependencies = @[
                              RamblerSelector(applicationConfigurator),
                              RamblerSelector(pushNotificationCenter),
                              RamblerSelector(thirdPartiesConfigurator)
                              ];
    
    // when
    id result = [self.assembly appDelegate];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesApplicationConfigurator {
    // given
    Class targetClass = [ApplicationConfiguratorImplementation class];
    
    // when
    id result = [self.assembly applicationConfigurator];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

- (void)testThatAssemblyCreatesPushNotificationCenter {
    // given
    Class targetClass = [PushNotificationCenterImplementation class];
    NSArray *dependencies = @[
                              RamblerSelector(pushNotificationCenter)
                              ];
    
    // when
    id result = [self.assembly pushNotificationCenter];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreates {
    // given
    Class targetClass = [ThirdPartiesConfiguratorImplementation class];
    
    // when
    id result = [self.assembly thirdPartiesConfigurator];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

@end
