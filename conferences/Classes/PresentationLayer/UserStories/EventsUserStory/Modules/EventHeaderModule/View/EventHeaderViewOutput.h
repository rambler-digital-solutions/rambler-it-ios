//
//  EventHeaderViewOutput.h
//  Conferences
//
//  Created by Karpushin Artem on 10/12/15.
//  Copyright 2015 Rambler. All rights reserved.
//
#import <Foundation/Foundation.h>

@class PlainEvent;

@protocol EventHeaderViewOutput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that module was cofigured with PlainEvent object
 
 @param event PlainEvent object
 */
- (void)moduleReadyWithEvent:(PlainEvent *)event;

@end

