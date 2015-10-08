//
//  ChainableOperationTestsBase.h
//  Conferences
//
//  Created by Egor Tolstoy on 03/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "XCTestCase+RCFHelpers.h"
#import "TestConstants.h"

@protocol ChainableOperation;

/**
 @author Egor Tolstoy
 
 The base class for ChainableOperation tests
 */
@interface ChainableOperationTestsBase : XCTestCase

/**
 @author Egor Tolstoy
 
 The method setups input data for an operation
 */
- (void)setInputData:(id)data
        forOperation:(NSOperation <ChainableOperation> *)operation;

/**
 @author Egor Tolstoy
 
 The method setups output data for an operation
 */
- (void)setOutputData:(id)data
         forOperation:(NSOperation <ChainableOperation> *)operation;

/**
 @author Egor Tolstoy
 
 The method checks output data of an operation
 
 @param operation Chainable operation
 */
- (void)verifyNotNilResultForOperation:(NSOperation <ChainableOperation> *)operation;

@end
