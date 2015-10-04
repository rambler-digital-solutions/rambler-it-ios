//
//  EventService.h
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSPredicate;
@class Event;

typedef void (^EventCompletionBlock)(Event *event, NSError *error);

/**
 @author Artem Karpushin
 
 The service is designed to obtain / update Event objects
 */
@protocol EventService <NSObject>

/**
 @author Artem Karpushin
 
 Method is used to obtain Event object from cache
 
 @param predicate NSPredicate for specifying the filtering parameters
 
 @return Event object
 */
- (Event *)obtainEventWithPredicate:(NSPredicate *)predicate;

/**
 @author Artem Karpushin
 
 Method is used to update Event object by sending request to server
 
 @param predicate NSPredicate for specifying the filtering parameters
 @param completionBlock EventCompletionBlock called upon completion the method, and returns Event object and NSError object if there is any
 */
- (void)updateEventWithPredicate:(NSPredicate *)predicate completionBlock:(EventCompletionBlock)completionBlock;

@end
