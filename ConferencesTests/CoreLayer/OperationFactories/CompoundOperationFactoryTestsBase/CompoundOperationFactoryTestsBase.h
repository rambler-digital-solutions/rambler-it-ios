//
//  CompoundOperationFactoryTestsBase.h
//  Conferences
//
//  Created by Egor Tolstoy on 08/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <MMBarricade/MMBarricade.h>
#import <Typhoon/TyphoonAutoInjection.h>
#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>

#import "XCTestCase+RCFHelpers.h"
#import "TestConstants.h"

#import "CompoundOperationBase.h"

@class MMBarricadeResponseSet;

typedef void(^CompoundOperationFactoryExpectationBlock)(id resultData, NSError *resultError);

/**
 @author Egor Tolstoy
 
 The base testCase for compound operations factories
 */
@interface CompoundOperationFactoryTestsBase : XCTestCase

/**
@author Egor Tolstoy

The request name for MMBarricade
*/
@property (strong, nonatomic) NSString *requestName;

/**
 @author Egor Tolstoy
 
 The URL suffix for stubbing responses
 */
@property (strong, nonatomic) NSString *requestSuffix;

/**
 @author Egor Tolstoy
 
 This method is used for initial setup for each test. It activates a number of hardcoded assemblies.
 If you want to use any definition from these assemblies, use TyphoonAutoInjection.
 */
- (void)setUp;

/**
 @author Egor Tolstoy
 
 This method is used for initial setup for each test. It activates a number of hardcoded assemblies.
 If you want to use any definition from these assemblies, use TyphoonAutoInjection.
 
 @param additionalCollaboratingAssemblies You can provide additional assemblies if needed for some test
 */
- (void)setUpWithAdditionalCollaboratingAssemblies:(NSArray *)additionalCollaboratingAssemblies;

/**
 @author Egor Tolstoy
 
 The method implements the base test for a compound operation. It calls start, waits for the resultBlock and passes the output data back to the test.
 
 @param compoundOperation Compound operation
 @param expectation       XCTestExpectation for the current test
 @param block             The block is fired when the operation is over
 */
- (void)testCompoundOperation:(CompoundOperationBase *)compoundOperation
                  expectation:(XCTestExpectation *)expectation
             expectationBlock:(CompoundOperationFactoryExpectationBlock)block;

/**
 @author Egor Tolstoy
 
 The basic network stubs setup
 
 @param responses   An array with network stubs for the concrete TestCase
 @param requestName The name of the current request
 @param suffix      URL suffix for using the right stub
 */
- (void)configureNetworkStubsWithResponses:(NSArray *)responses
                               requestName:(NSString *)requestName
                         requestPathSuffix:(NSString *)suffix;

/**
 @author Egor Tolstoy
 
 The method returns a path to a specified response
 
 @param name The name of the response
 
 @return The path to the repsonse
 */
- (NSString *)pathForResponseWithName:(NSString *)name;

@end
