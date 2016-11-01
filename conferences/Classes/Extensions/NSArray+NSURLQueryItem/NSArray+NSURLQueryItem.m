//
//  NSArray+NSURLQueryItem.m
//  Conferences
//
//  Created by Trishina Ekaterina on 28/10/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "NSArray+NSURLQueryItem.h"

@implementation NSArray (NSURLQueryItem)

- (id)queryValueForKey:(NSString *)key {
    if (key == nil) {
        return nil;
    }

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", key];
    NSURLQueryItem *queryItem = [[self filteredArrayUsingPredicate:predicate] firstObject];
    return queryItem.value;
}

@end
