//
//  RCFResponseValidatorBase.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ResponseValidatorBase.h"

static NSString *const kResponseValidationErrorDomain = @"ru.rambler.conferences.validation-error-domain";

static NSUInteger const kInvalidResponseErrorCode = 1;

@implementation ResponseValidatorBase

- (BOOL)validateResponseIsDictionaryClass:(id)response
                                    error:(NSError *__autoreleasing *)error {
    if (![response isKindOfClass: [NSDictionary class]]) {
        NSDictionary *userData = @{
                                   @"response" : (response ?: [NSNull null])
                                   };
        *error = [NSError errorWithDomain:kResponseValidationErrorDomain
                                     code:kInvalidResponseErrorCode
                                 userInfo:userData];
        return NO;
    }
    return YES;
}

#pragma mark - Debug Description

- (NSString *)debugDescription {
    return NSStringFromClass([self class]);
}

@end
