//
//  EventHeaderModuleInput.h
//  Conferences
//
//  Created by Karpushin Artem on 24/12/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlainEvent;

@protocol EventHeaderModuleInput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to configure module
 
 @param event PlainEvent object
 */
- (void)configureModuleWithEvent:(PlainEvent *)event;

@end
