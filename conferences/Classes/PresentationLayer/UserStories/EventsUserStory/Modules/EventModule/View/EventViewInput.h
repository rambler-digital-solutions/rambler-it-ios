//
//  EventViewInput.h
//  Conferences
//
//  Created by Karpushin Artem on 01/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlainEvent;

@protocol EventViewInput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to configure view
 
 @param event PlainEvent object
 */
- (void)configureViewWithEvent:(PlainEvent *)event;

@end

