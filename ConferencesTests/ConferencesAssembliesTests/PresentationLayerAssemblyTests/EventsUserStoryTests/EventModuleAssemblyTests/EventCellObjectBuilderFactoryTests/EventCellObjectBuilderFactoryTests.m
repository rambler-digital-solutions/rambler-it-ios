//
//  EventCellObjectBuilderFactoryTests.m
//  Conferences
//
//  Created by Karpushin Artem on 21/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "EventCellObjectBuilderFactory.h"
#import "EventCellObjectBuilderFactory_Testable.h"
#import "CurrentEventCellObjectBuilder.h"
#import "FutureEventCellObjectBuilder.h"
#import "PastEventCellObjectBuilder.h"

@interface EventCellObjectBuilderFactoryTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) EventCellObjectBuilderFactory *factory;

@end

@implementation EventCellObjectBuilderFactoryTests

- (void)setUp {
    [super setUp];
    
    self.factory = [EventCellObjectBuilderFactory new];
    [self.factory activate];
}

- (void)tearDown {
    self.factory = nil;

    [super tearDown];
}

- (void)testThatAssemblyCreatesCurrentEventCellObjectBuilder {
    // given
    Class targetClass = [CurrentEventCellObjectBuilder class];
    
    // when
    id result = [self.factory currentEventCellObjectBuilder];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

- (void)testThatAssemblyCreatesFutureEventCellObjectBuilder {
    // given
    Class targetClass = [FutureEventCellObjectBuilder class];
    
    // when
    id result = [self.factory futureEventCellObjectBuilder];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

- (void)testThatAssemblyCreatesPastEventCellObjectBuilder {
    // given
    Class targetClass = [PastEventCellObjectBuilder class];
    
    // when
    id result = [self.factory pastEventCellObjectBuilder];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

@end
