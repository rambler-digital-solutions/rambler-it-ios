//
//  PresentationLayerHelpersAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 22/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "PresentationLayerHelpersAssembly.h"

#import "EventTypeDeterminator.h"

@interface PresentationLayerHelpersAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) PresentationLayerHelpersAssembly *assembly;

@end

@implementation PresentationLayerHelpersAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [PresentationLayerHelpersAssembly new];
    [self.assembly activate];
}

- (void)tearDown {
    self.assembly = nil;

    [super tearDown];
}

- (void)testThatAssemblyCreates {
    // given
    Class targetClass = [EventTypeDeterminator class];
    
    // when
    id result = [self.assembly eventTypeDeterminator];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass];
}

@end
