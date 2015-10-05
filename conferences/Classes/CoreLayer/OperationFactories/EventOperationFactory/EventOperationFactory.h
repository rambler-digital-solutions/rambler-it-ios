//
//  EventOperationFactory.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NetworkCompoundOperationBuilder;
@class CompoundOperationBase;
@class EventQuery;

/**
 @author Egor Tolstoy
 
 The operation factory for building Event operations
 */
@interface EventOperationFactory : NSObject

/**
 @author Egor Tolstoy
 
 The main initializer of the current operation factory
 
 @param builder Compound operation builder
 
 @return EventOperationFactory
 */
- (instancetype)initWithBuilder:(NetworkCompoundOperationBuilder *)builder;

/**
 @author Egor Tolstoy
 
 The method returns a compound operation for obtaining all events
 
 @param query The query object
 
 @return CompoundOperationBase
 */
- (CompoundOperationBase *)getEventsOperationWithQuery:(EventQuery *)query;

@end
