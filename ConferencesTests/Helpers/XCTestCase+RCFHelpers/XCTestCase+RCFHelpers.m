//
//  XCTestCase+RCFHelpers.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "XCTestCase+RCFHelpers.h"

@implementation XCTestCase (RCFHelpers)

- (XCTestExpectation *)expectationForCurrentTest {
    SEL testSelector = self.invocation.selector;
    NSString *selectorString = NSStringFromSelector(testSelector);
    NSString *expectationDescription = [NSString stringWithFormat:@"Expectation for %@ test", selectorString];
    return [self expectationWithDescription:expectationDescription];
}

- (void)fulfillExpectationInMainThread:(XCTestExpectation *)expectation {
    dispatch_async(dispatch_get_main_queue(), ^{
        [expectation fulfill];
    });
}

@end
