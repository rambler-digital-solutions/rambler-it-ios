//
//  RCFManagedObjectMapperTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MagicalRecord/MagicalRecord.h>

#import "RCFManagedObjectMapper.h"
#import "RCFManagedObjectMappingProvider.h"
#import "RCFResultsResponseObjectFormatter.h"

@interface RCFManagedObjectMapperTests : XCTestCase

@property (strong, nonatomic) RCFManagedObjectMapper *mapper;

@end

@implementation RCFManagedObjectMapperTests

- (void)setUp {
    [super setUp];
    
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    
    RCFManagedObjectMappingProvider *provider = [[RCFManagedObjectMappingProvider alloc] init];
    RCFResultsResponseObjectFormatter *formatter = [[RCFResultsResponseObjectFormatter alloc] init];
    self.mapper = [[RCFManagedObjectMapper alloc] initWithMappingProvider:provider
                                                  responseObjectFormatter:formatter];
}

- (void)tearDown {
    self.mapper = nil;
    
    [MagicalRecord cleanUp];
    
    [super tearDown];
}

- (void)testThatMapperMapsSocialNetworkAccount {
    // given
    NSDictionary *serverResponse = @{
                                     @"results": @[
                                                 @{
                                                     @"createdAt": @"2015-10-04T12:01:59.391Z",
                                                     @"name": @"Twitter",
                                                     @"objectId": @"5aU1er9TO6",
                                                     @"profileLink": @"https://twitter.com/igrekde",
                                                     @"speaker": @{
                                                         @"__type": @"Relation",
                                                         @"className": @"Speaker"
                                                     },
                                                     @"updatedAt": @"2015-10-04T12:02:09.462Z"
                                                 }
                                                 ]
                                     };
    
    // when
    NSArray *result = [self.mapper mapServerResponse:serverResponse
                                  withMappingContext:@{@"kMappingContextManagedObjectClassKey":@"SocialNetworkAccount"}
                                               error:nil];
    
    // then
    XCTAssertEqual(result.count, 1);
    
}

@end
