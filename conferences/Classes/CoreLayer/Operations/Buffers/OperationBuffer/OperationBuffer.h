//
//  OperationBuffer.h
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChainableOperationInput.h"
#import "ChainableOperationOutput.h"
#import "CompoundOperationQueueInput.h"
#import "CompoundOperationQueueOutput.h"

/**
 @author Egor Tolstoy
 
 The mediator class between compound operation's elements.
 
 We are using it to reduce coupling between two suboperations. It allows us to build any possible combination with different suboperations unawared of each other.
 Besides it, this buffer is used to chain the compound operation with the first and last suboperations from its queue.
 */
@interface OperationBuffer : NSObject <ChainableOperationInput, ChainableOperationOutput, CompoundOperationQueueInput, CompoundOperationQueueOutput>

+ (instancetype)buffer;

@end
