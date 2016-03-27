//
//  ErrorConstants.h
//  Conferences
//
//  Created by Karpushin Artem on 27/03/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Error domains

extern NSString * const ErrorDomain;

#pragma mark - Error codes

typedef NS_ENUM(NSInteger, ErrorCode) {
    
    /**
     @author Artem Karpushin
     
     Event is already stored in the calendar
     */
    ErrorEventAlreadyStoredInCalendar = 102
};
