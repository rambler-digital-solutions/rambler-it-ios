//
//  DateFormatter.h
//  Conferences
//
//  Created by Karpushin Artem on 06/12/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Artem Karpushin
 
 Class is designed to cast a date to a specific format
 */
@interface DateFormatter : NSObject

/**
 @author Artem Karpushin
 
 Method is used to obtain string from date with format ""
 
 @param date NSDate object
 
 @return NSString object
 */
- (NSString *)obtainDateWithDayMonthTimeFormat:(NSDate *)date;

/**
 @author Artem Karpushin
 
 Method is used to obtain string from date with format ""
 
 @param date NSDate object
 
 @return NSString object
 */
- (NSString *)obtainDateWithDayMonthYearFormat:(NSDate *)date;

/**
 @author Artem Karpushin
 
 Method is used to obtain string from date with format ""
 
 @param date NSDate object
 
 @return NSString object
 */
- (NSString *)obtainDateWithDayMonthFormat:(NSDate *)date;

@end
