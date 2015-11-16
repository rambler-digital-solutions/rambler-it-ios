//
//  EventType.h
//  Conferences
//
//  Created by Karpushin Artem on 14/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#ifndef EventType_h
#define EventType_h

/**
 @author Artem Karpushin
 
 Enum represents event type
 */
typedef  NS_ENUM(NSUInteger, EventType) {
    FutureEvent = 0,
    CurrentEvent = 1,
    PastEvent = 2
};

#endif
