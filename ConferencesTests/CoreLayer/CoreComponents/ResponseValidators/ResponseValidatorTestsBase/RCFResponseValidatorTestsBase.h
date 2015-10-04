//
//  RCFParseResponseValidatorTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>

@protocol RCFResponseValidator;

/**
 @author Egor Tolstoy
 
 The base class for ResponseValidators tests
 */
@interface RCFResponseValidatorTestsBase : XCTestCase

/**
 @author Egor Tolstoy
 
 This test ensures that the validator is handling correct data right
 
 @param validator Server response validator
 @param response  Deserialized server response
 */
- (void)verifyThatValidator:(id<RCFResponseValidator>)validator
   validatesCorrectResponse:(NSArray *)response;

/**
 @author Egor Tolstoy
 
 This test ensures that the validator is handling incorrect data right
 
 @param validator Server response validator
 @param response  Deserialized server response
 */
- (void)verifyThatValidator:(id<RCFResponseValidator>)validator
 validatesIncorrectResponse:(NSArray *)response;

@end
