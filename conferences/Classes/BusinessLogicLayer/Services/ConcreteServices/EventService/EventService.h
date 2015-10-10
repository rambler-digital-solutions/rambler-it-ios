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

@protocol EventService <NSObject>

- (Event *)obtainEventWithPredicate:(NSPredicate *)predicate;

- (void)updateEventWithPredicate:(NSPredicate *)predicate completionBlock:(EventCompletionBlock)completionBlock;

@end
