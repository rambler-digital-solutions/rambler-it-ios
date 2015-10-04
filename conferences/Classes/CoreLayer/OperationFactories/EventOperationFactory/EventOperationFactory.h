//
//  EventOperationFactory.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CompoundOperationBase;
@class EventQuery;

@interface EventOperationFactory : NSObject

- (CompoundOperationBase *)getEventsOperationWithQuery:(EventQuery *)query;

@end
