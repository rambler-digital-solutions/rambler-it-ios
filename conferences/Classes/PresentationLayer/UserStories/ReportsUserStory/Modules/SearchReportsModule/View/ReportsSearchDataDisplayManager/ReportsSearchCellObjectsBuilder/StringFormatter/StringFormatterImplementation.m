//
//  StringFormatterImplementation.m
//  Conferences
//
//  Created by a.yakimenko on 24.10.2017.
//  Copyright © 2017 Rambler. All rights reserved.
//

#import "StringFormatterImplementation.h"

static NSString *const DefaultStringSeparator = @"";

@implementation StringFormatterImplementation

- (nullable NSAttributedString *)colorLinksStringFromString:(nonnull NSString *)string
                                                      сolor:(nonnull UIColor *)color
                                                  separator:(nonnull NSString *)separator {
    if (string == nil || color == nil) {
        return nil;
    }
    
    NSString *stringSeparator;
    
    if (separator == nil) {
        stringSeparator = DefaultStringSeparator;
    } else {
        stringSeparator = separator;
    }
    
    NSMutableAttributedString *linkString = [[NSMutableAttributedString alloc] initWithString:string];
    
    if (string.length != 0) {
        NSCharacterSet *separatingCharacters = [NSCharacterSet characterSetWithCharactersInString:stringSeparator];
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
