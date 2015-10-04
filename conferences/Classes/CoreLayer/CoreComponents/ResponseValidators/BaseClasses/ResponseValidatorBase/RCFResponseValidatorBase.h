//
//  RCFResponseValidatorBase.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 The base class for concrete server response validators. It contains a number of common methods for validating data structures.
 */
@interface RCFResponseValidatorBase : NSObject

/**
 @author Egor Tolstoy
 
 This method validates that the provided structure is a dictionary
 
 @param response Deserialized server response
 @param error    NSError
 
 @return The flag indicating the result of the validation process
 */
- (BOOL)validateResponseIsDictionaryClass:(id)response error:(NSError **)error;

@end
