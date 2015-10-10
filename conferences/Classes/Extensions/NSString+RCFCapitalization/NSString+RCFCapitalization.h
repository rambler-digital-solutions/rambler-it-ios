//
//  NSString+RCFCapitalization.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 This category provides some methods for modifying the capitalization of a given NSString object
 */
@interface NSString (RCFCapitalization)

/**
 @author Egor Tolstoy
 
 This method change the capitalization of the first letter in the string (e.g. FooBar -> fooBar)
 
 @return Decapitalized string
 */
- (NSString *)rcf_decapitalizedStringSavingCase;

@end
