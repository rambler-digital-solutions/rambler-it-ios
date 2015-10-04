//
//  RCFResponseValidatorBase.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "RCFResponseValidatorBase.h"

static NSString *const kResponseValidationErrorDomain = @"ru.rambler.conferences.validation-error-domain";

static NSUInteger const kInvalidResponseErrorCode = 1;

@implementation RCFResponseValidatorBase

- (BOOL)validateResponseIsDictionaryClass:(id)response
                                    error:(NSError *__autoreleasing *)error {
    if (response == nil || ![response isKindOfClass: [NSDictionary class]]) {
        NSDictionary *userData = @{
                                   @"response" : (response == nil ? [NSNull null] : response)
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
