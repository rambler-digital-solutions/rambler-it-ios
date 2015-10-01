//
//  RCFEventService.h
//  Conferences
//
//  Created by Karpushin Artem on 01/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSPredicate;
@class Event;

typedef void (^RCFEventCompletionBlock)(Event *event, NSError *error);

@protocol RCFEventService <NSObject>

- (Event *)obtainEventWithPredicate:(NSPredicate *)predicate;

- (void)updateEventWithPredicate:(NSPredicate *)predicate completionBlock:(RCFEventCompletionBlock)completionBlock;

@end
