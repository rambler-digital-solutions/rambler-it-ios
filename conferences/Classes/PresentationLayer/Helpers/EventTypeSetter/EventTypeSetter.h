//
//  EventTypeSetter.h
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlainEvent;

/**
 @author Artem Karpushin
 
 Helper class is designed to set event type
 */
@interface EventTypeSetter : NSObject

/**
 @author Artem Karpushin
 
 Method is used to set event type (future, current or past) depending on current time
 
 @param event PlainEvent object
 */
- (void)setTypeForEvent:(PlainEvent *)event;

@end
