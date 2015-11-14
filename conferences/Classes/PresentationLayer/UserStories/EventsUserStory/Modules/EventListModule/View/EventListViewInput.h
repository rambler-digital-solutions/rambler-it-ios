//
//  EventListViewInput.h
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlainEvent;

@protocol EventListViewInput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to set up current view with events
 
 @param events Array of PlainEvent objects
 */
- (void)setupViewWithEventList:(NSArray *)events;

/**
 @author Artem Karpushin
 
 Method is used to update current view with events
 
 @param events Array of PlainEvent objects
 */
- (void)updateViewWithEventList:(NSArray *)events;

@end

