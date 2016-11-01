//
//  NSArray+NSURLQueryItem.h
//  Conferences
//
//  Created by Trishina Ekaterina on 28/10/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSURLQueryItem;

/**
 @author Trishina Ekaterina

 Working with NSURLQueryItem like with dictionary
 */
@interface NSArray (NSURLQueryItem)

- (nullable NSString *)queryValueForKey:(nullable NSString *)key;

@end
