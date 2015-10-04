//
//  XCTestCase+RCFHelpers.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>

/**
 @author Egor Tolstoy
 
 The category on the XCTestCase contains a number of helper methods to reduce the boilerplate code.
 */
@interface XCTestCase (RCFHelpers)

/**
 @author Egor Tolstoy
 
 This method returns a XCTestEpectation object with an auto-generted description for the current test.
 
 @return Preconfigured XCTestExpectation
 */
- (XCTestExpectation *)expectationForCurrentTest;

/**
 @author Egor Tolstoy
 
 This method calls the fulfill method for the given expectation in the main thread.
 
 @param expectation XCTestExpectation for the current test
 */
- (void)fulfillExpectationInMainThread:(XCTestExpectation *)expectation;

@end
