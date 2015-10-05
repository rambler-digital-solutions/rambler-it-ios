//
//  ResponseValidatorsAssembly.m
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ResponseValidatorsAssembly.h"

#import "RCFParseResponseValidator.h"

@implementation ResponseValidatorsAssembly

#pragma mark - Option matcher

- (id<RCFResponseValidator>)validatorWithType:(NSNumber *)type {
    return [TyphoonDefinition withOption:type matcher:^(TyphoonOptionMatcher *matcher) {
        [matcher caseEqual:@(ResponseValidationParseType)
                       use:[self parseResponseValidator]];
    }];
}

#pragma mark - Concrete definitions

- (id<RCFResponseValidator>)parseResponseValidator {
    return [TyphoonDefinition withClass:[RCFParseResponseValidator class]];
}

@end
