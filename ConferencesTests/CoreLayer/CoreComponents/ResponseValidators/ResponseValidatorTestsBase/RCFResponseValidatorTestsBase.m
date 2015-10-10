//
//  RCFParseResponseValidatorTests.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "RCFResponseValidatorTestsBase.h"
#import "ResponseValidator.h"

@implementation RCFResponseValidatorTestsBase

- (void)verifyThatValidator:(id<ResponseValidator>)validator
  validatesCorrectResponse :(NSArray *)response {
    // given
    
    // when
    NSMutableArray *resultErrors = [NSMutableArray array];
    for (NSDictionary *dictionary in response) {
        NSError *error = [validator validateServerResponse:dictionary];
        
        if (error) {
            [resultErrors addObject:error];
        }
    }
    
    // then
    XCTAssertEqual(resultErrors.count, 0);
}

- (void)verifyThatValidator:(id<ResponseValidator>)validator
validatesIncorrectResponse :(NSArray *)response {
    // given
    
    // when
    NSMutableArray *resultErrors = [NSMutableArray array];
    for (NSDictionary *dictionary in response) {
        NSError *error = [validator validateServerResponse:dictionary];
        
        if (error) {
            [resultErrors addObject:error];
        }
    }
    
    // then
    XCTAssertGreaterThan(resultErrors.count, 0);
}

@end
