//
//  EventListInteractorOutput.h
//  Conferences
//
//  Created by Karpushin Artem on 12/10/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlainEvent;

@protocol EventListInteractorOutput <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to inform presenter that list of events has been updated
 
 @param events Array of PlainEvent objects
 */
- (void)didUpdateEventList:(NSArray *)events;

@end

