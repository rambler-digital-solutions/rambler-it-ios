//
//  ChainableOperation.h
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChainableOperationInput.h"
#import "ChainableOperationOutput.h"
#import "ChainableOperationDelegate.h"
#import "OperationDebugDescriptionFormatter.h"

/**
 @author Egor Tolstoy
 
 The protocol describes an operation, suited for working in compound operation's chain
 */
@protocol ChainableOperation <NSObject>

/**
 @author Egor Tolstoy
 
 The operation's delegate, which is informed when the operation is finished
 */
@property (weak, nonatomic) id<ChainableOperationDelegate> delegate;

/**
 @author Egor Tolstoy
 
 Inpud data source for the operation
 */
@property (strong, nonatomic) id<ChainableOperationInput> input;

/**
 @author Egor Tolstoy
 
 The container for the result of operation's work
 */
@property (strong, nonatomic) id<ChainableOperationOutput> output;

@end
