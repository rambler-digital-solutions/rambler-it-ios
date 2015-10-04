//
//  EventOperationFactory.m
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "EventOperationFactory.h"

#import "CompoundOperationBase.h"
#import "EventQuery.h"

@implementation EventOperationFactory

- (CompoundOperationBase *)getEventsOperationWithQuery:(EventQuery *)query {
    return nil;
}

@end
