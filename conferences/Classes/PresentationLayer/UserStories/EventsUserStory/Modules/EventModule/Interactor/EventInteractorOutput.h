//
//  EventInteractorOutput.h
//  Conferences
//
//  Created by Karpushin Artem on 01/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlainEvent;

@protocol EventInteractorOutput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that Event object was obtained
 
 @param event PlainEvent object
 */
- (void)didObtainEvent:(PlainEvent *)event;

@end

