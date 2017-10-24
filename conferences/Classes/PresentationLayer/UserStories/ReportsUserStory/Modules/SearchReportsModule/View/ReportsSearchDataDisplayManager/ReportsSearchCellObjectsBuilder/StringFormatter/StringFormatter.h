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
 
 Method creates instance of NSAttributedString for certain string with given color.
 
 @param string - certain string
 @param color - given color
 */
- (nullable NSAttributedString *)linkStringFromString:(nonnull NSString *)string
                                            withColor:(nonnull UIColor *)color;

@end
