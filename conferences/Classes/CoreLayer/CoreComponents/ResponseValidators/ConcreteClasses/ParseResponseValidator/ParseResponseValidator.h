//
//  ParseResponseValidator.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ResponseValidatorBase.h"

#import "ResponseValidator.h"

/**
 @author Egor Tolstoy
 
 This implementation of RCFResponseValidator is reponsible for validating responses from the Parse REST API.
 This validator is very simple - the only constraint is that response should be of NSDictionary class.
 */
@interface ParseResponseValidator : ResponseValidatorBase <ResponseValidator>

@end
