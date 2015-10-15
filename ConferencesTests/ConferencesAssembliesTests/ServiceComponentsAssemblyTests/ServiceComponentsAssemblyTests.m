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

#import "PushNotificationServiceImplementation.h"

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

@end
