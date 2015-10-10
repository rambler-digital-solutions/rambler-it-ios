//
//  ChainableOperationOutput.h
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 The protocol for the operation output data container
 */
@protocol ChainableOperationOutput <NSObject>

/**
 @author Egor Tolstoy
 
 The method passes the operation's result to the container
 
 @param outputData The operation's result
 */
- (void)didCompleteChainableOperationWithOutputData:(id)outputData;

@end
