//
//  RCFResponseValidator.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 This protocol defines an object responsible for validating deserialized server responses. It ensures that the data structure is valid and doesn't contain any errors.
 */
@protocol RCFResponseValidator <NSObject>

/**
 @author Egor Tolstoy
 
 This method initiates the response validation process
 
 @param response Deserialized server response
 
 @return NSError with the validation error description
 */
- (NSError *)validateServerResponse:(id)response;

@end
