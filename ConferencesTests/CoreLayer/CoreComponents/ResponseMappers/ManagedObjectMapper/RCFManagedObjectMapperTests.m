//
//  RCFManagedObjectMapperTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MagicalRecord/MagicalRecord.h>

#import "ManagedObjectMapper.h"
#import "ManagedObjectMappingProvider.h"
#import "ResultsResponseObjectFormatter.h"

#import "SocialNetworkAccount.h"
#import "NetworkingConstantsHeader.h"

@interface RCFManagedObjectMapperTests : XCTestCase

@property (strong, nonatomic) ManagedObjectMapper *mapper;

@end

@implementation RCFManagedObjectMapperTests

- (void)setUp {
    [super setUp];
    
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    
    ManagedObjectMappingProvider *provider = [[ManagedObjectMappingProvider alloc] init];
    ResultsResponseObjectFormatter *formatter = [[ResultsResponseObjectFormatter alloc] init];
    self.mapper = [[ManagedObjectMapper alloc] initWithMappingProvider:provider
                                                  responseObjectFormatter:formatter];
}

- (void)tearDown {
    self.mapper = nil;
    
    [MagicalRecord cleanUp];
    
    [super tearDown];
}

- (void)testThatMapperMapsSocialNetworkAccount {
    // given
    Class targetClass = [SocialNetworkAccount class];
    NSDictionary *serverResponse = [self generateServerResponseForModelClass:targetClass];
    NSDictionary *mappingContext = [self generateMappingContextForModelClass:targetClass];
    
    // when
    NSArray *result = [self.mapper mapServerResponse:serverResponse
                                  withMappingContext:mappingContext
                                               error:nil];
    id firstObject = [result firstObject];
    
    // then
    XCTAssertEqual(result.count, 1);
    XCTAssertTrue([firstObject isKindOfClass:targetClass]);
    XCTAssertNotNil([firstObject objectId]);
    XCTAssertNotNil([firstObject name]);
    XCTAssertNotNil([firstObject profileLink]);
}

#pragma mark - Helper Methods

- (NSDictionary *)generateMappingContextForModelClass:(Class)modelClass {
    NSString *className = NSStringFromClass(modelClass);
    return @{
             kMappingContextModelClassKey : className
             };
}

- (NSDictionary *)generateServerResponseForModelClass:(Class)modelClass {
    Class testCaseClass = [self class];
    
    NSString *bundleName = NSStringFromClass(testCaseClass);
    NSString *modelName = NSStringFromClass(modelClass);
    NSString *fileName = [NSString stringWithFormat:@"%@.json", modelName];
    
    NSBundle *resourceBundle = [NSBundle bundleForClass:testCaseClass];
    
    NSString *pathToTestBundle = [resourceBundle pathForResource:bundleName ofType:@"bundle"];
    NSBundle *testBundle = [NSBundle bundleWithPath:pathToTestBundle];
    
    NSString *pathToFile = [[testBundle resourcePath] stringByAppendingPathComponent:fileName];
    NSData *responseData = [NSData dataWithContentsOfFile:pathToFile
                                                  options:0
                                                    error:nil];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:nil];
    
    return json;
}

@end
