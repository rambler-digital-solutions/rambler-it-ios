//
//  EventTypeSetter.h
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventType.h"

@class PlainEvent;

/**
 @author Artem Karpushin
 
 Helper class is designed to determinate event type
 */
@interface EventTypeDeterminator : NSObject

/**
 @author Artem Karpushin
 
 Method is used to determinate event type (future, current or past) depending on current time
 
 @param event PlainEvent object
 */
- (EventType)determinateTypeForEvent:(PlainEvent *)event;

@end
