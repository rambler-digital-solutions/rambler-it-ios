//
//  OperationScheduler.h
//  Conferences
//
//  Created by Egor Tolstoy on 06/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 The protocol defines an object, which is responsible for scheduling a number of operations and solving different synchronization tasks.
 */
@protocol OperationScheduler <NSObject>

/**
 @author Egor Tolstoy
 
 The method adds a new operation to the scheduler's inner queue
 
 @param operation Any NSOperation
 */
- (void)addOperation:(NSOperation *)operation;

@end
