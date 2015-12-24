//
//  EventHeaderViewInput.h
//  Conferences
//
//  Created by Karpushin Artem on 10/12/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlainEvent;

@protocol EventHeaderViewInput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to configure view with event data
 
 @param event PlainEvent object
 */
- (void)configureViewWithEvent:(PlainEvent *)event;

@end

