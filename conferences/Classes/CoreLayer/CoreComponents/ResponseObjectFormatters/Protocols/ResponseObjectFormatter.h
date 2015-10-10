//
//  RCFResponseObjectFormatter.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 This protocol defines a behaviour of objects, responsible for formatting server response for a specific formatter.
 */
@protocol ResponseObjectFormatter <NSObject>

/**
 @author Egor Tolstoy
 
 This method formats a deserialized server response with its own set of rules
 
 @param serverResponse Deserialized server response
 
 @return Formatted server response
 */
- (id)formatServerResponse:(id)serverResponse;

@end
