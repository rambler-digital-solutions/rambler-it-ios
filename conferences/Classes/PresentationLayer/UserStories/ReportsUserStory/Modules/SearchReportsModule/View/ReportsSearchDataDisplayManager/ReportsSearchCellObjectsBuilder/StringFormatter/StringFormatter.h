//
//  StringFormatter.h
//  Conferences
//
//  Created by a.yakimenko on 24.10.2017.
//  Copyright © 2017 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Aleksey Yakimenko
 
 Describes an object, which used for formating instances of NSString.
 */
@protocol StringFormatter <NSObject>

/**
 @author Aleksey Yakimenko
 
 Method creates instance of NSAttributedString for certain string. The string is divided into substrings ending with separator. New attributed string gets two attributes (NSForegroundColorAttributeName, NSLinkAttributeName) for ranges of every substring. Value for NSForegroundColorAttributeName is given color and for NSLinkAttributeName is particular substring.
 
 @param string - certain string
 @param color - given color
 @param separator - given separator
 */
- (nullable NSAttributedString *)colorLinksStringFromString:(nonnull NSString *)string
                                                      сolor:(nonnull UIColor *)color
                                                  separator:(nonnull NSString *)separator;

@end
