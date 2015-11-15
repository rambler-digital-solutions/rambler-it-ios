//
//  ServiceComponentsAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 15/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerMcFlurry/Testing.h>

#import "ServiceComponents.h"
#import "ServiceComponentsAssembly.h"
#import "ServiceComponentsAssembly_Testable.h"

#import "PushNotificationServiceImplementation.h"
#import "EventServiceImplementation.h"
#import "PushNotificationServiceImplementation.h"
#import "OperationScheduler.h"
#import "OperationSchedulerImplementation.h"
#import "PrototypeMapper.h"
#import "EventPrototypeMapper.h"

@interface ServiceComponentsAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) ServiceComponentsAssembly *assembly;

@end

@implementation ServiceComponentsAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [ServiceComponentsAssembly new];
    [self.assembly activate];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesPushNotificationService {
    // given
    Class targetClass = [PushNotificationServiceImplementation class];
    
    // when
    id result = [self.assembly pushNotificationService];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

- (void)testThatAssemblyCreatesEventService {
    // given
    Class targetClass = [EventServiceImplementation class];
    NSArray *dependencies = @[
                              RamblerSelector(eventOperationFactory),
                              RamblerSelector(operationScheduler)
                              ];
    // when
    id result = [self.assembly eventService];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesOperationScheduler {
    // given
    Class targetClass = [OperationSchedulerImplementation class];

    // when
    id result = [self.assembly operationScheduler];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

- (void)testThatAssemblyCreatesEventPrototypeMapper {
    // given
    Class targetClass = [EventPrototypeMapper class];

    // when
    id result = [self.assembly eventPrototypeMapper];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

@end
