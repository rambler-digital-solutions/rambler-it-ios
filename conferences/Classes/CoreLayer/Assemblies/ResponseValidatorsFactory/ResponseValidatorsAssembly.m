//
//  ResponseValidatorsAssembly.m
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ResponseValidatorsAssembly.h"

#import "ParseResponseValidator.h"

@implementation ResponseValidatorsAssembly

#pragma mark - Option matcher

- (id<ResponseValidator>)validatorWithType:(NSNumber *)type {
    return [TyphoonDefinition withOption:type matcher:^(TyphoonOptionMatcher *matcher) {
        [matcher caseEqual:@(ResponseValidationParseType)
                       use:[self parseResponseValidator]];
    }];
}

#pragma mark - Concrete definitions

- (id<ResponseValidator>)parseResponseValidator {
    return [TyphoonDefinition withClass:[ParseResponseValidator class]];
}

@end
