// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <XCTest/XCTest.h>

typedef void (^ProxyBlock)(NSInvocation *);

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
