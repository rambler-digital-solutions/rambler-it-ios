//
//  NSString+RCFCapitalization.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "NSString+RCFCapitalization.h"

@implementation NSString (RCFCapitalization)

- (NSString *)rcf_decapitalizedStringSavingCase {
    if (!self.length) {
        return self;
    }
    NSString *firstSymbol = [self substringToIndex:1];
    return [self stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                         withString:[firstSymbol lowercaseString]];
}

@end
