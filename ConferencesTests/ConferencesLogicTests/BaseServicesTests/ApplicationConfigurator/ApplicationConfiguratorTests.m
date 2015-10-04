//
//  ApplicationConfiguratorTests.m
//  Conferences
//
//  Created by Karpushin Artem on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "ApplicationConfigurator.h"
#import "ApplicationConfiguratorImplementation.h"

#import <MagicalRecord/MagicalRecord.h>

@interface ApplicationConfiguratorTests : XCTestCase

@property (strong, nonatomic) id <ApplicationConfigurator> applicationConfigurator;

@end

@implementation ApplicationConfiguratorTests

- (void)setUp {
    [super setUp];
    
    self.applicationConfigurator = [ApplicationConfiguratorImplementation new];
}

- (void)tearDown {
    self.applicationConfigurator = nil;
    
    [super tearDown];
}

- (void)testSuccessSetupCoreDataStack {
    // given
    id mockMagicalRecord = OCMClassMock([MagicalRecord class]);
    
    // when
    [self.applicationConfigurator setupCoreDataStack];
    
    // then
    OCMVerify([mockMagicalRecord setupCoreDataStackWithStoreNamed:OCMOCK_ANY]);
}

@end
