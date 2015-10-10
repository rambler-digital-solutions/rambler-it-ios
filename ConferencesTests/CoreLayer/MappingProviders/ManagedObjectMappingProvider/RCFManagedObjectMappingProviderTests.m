//
//  RCFManagedObjectMappingProviderTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EasyMapping/EasyMapping.h>

#import "ManagedObjectMappingProvider.h"
#import "SocialNetworkAccount.h"

@interface RCFManagedObjectMappingProviderTests : XCTestCase

@property (strong, nonatomic) ManagedObjectMappingProvider *provider;

@end

@implementation RCFManagedObjectMappingProviderTests

- (void)setUp {
    [super setUp];
    
    self.provider = [[ManagedObjectMappingProvider alloc] init];
}

- (void)tearDown {
    self.provider = nil;
    
    [super tearDown];
}

- (void)testThatProviderReturnsProperMappingForOneOfModels {
    // given
    Class targetClass = [SocialNetworkAccount class];
    NSString *const kExpectedEntityName = NSStringFromClass(targetClass);
    
    // when
    EKManagedObjectMapping *mapping = [self.provider mappingForManagedObjectModelClass:targetClass];
    
    // then
    XCTAssertEqualObjects(mapping.entityName, kExpectedEntityName);
}

@end
