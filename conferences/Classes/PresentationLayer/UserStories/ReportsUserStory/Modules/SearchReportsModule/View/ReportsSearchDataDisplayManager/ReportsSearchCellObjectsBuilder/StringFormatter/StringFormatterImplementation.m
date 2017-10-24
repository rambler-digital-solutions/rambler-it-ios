//
//  StringFormatterImplementation.m
//  Conferences
//
//  Created by a.yakimenko on 24.10.2017.
//  Copyright © 2017 Rambler. All rights reserved.
//

#import "StringFormatterImplementation.h"

@implementation StringFormatterImplementation

- (nullable NSAttributedString *)linkStringFromString:(nonnull NSString *)string
                                            withColor:(nonnull UIColor *)color {
    if (string == nil || color == nil) {
        return nil;
    }
    
    NSMutableAttributedString *linkString = [[NSMutableAttributedString alloc] initWithString:string];
    
    if (string.length != 0) {
        NSCharacterSet *separatingCharacters = [NSCharacterSet characterSetWithCharactersInString:@", "];
        NSArray *separatedStrings = [string componentsSeparatedByCharactersInSet:separatingCharacters];
        
        for (NSString *separatedString in separatedStrings) {
            if (separatedString.length == 0) {
                continue;
            }
            
            NSRange range = [string.lowercaseString rangeOfString:separatedString];
            [linkString addAttribute:NSForegroundColorAttributeName
                              value:color
                              range:range];
            
            [linkString addAttribute:NSLinkAttributeName
                              value:separatedString
                              range:range];
        }
    }
    return [linkString copy];
}

@end
