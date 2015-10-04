//
//  CompoundOperationDebugDescriptionFormatter.h
//  Conferences
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CompoundOperationBase;

/**
 @author Egor Tolstoy
 
 This object formats the CompoundOperation description for logging it
 */
@interface CompoundOperationDebugDescriptionFormatter : NSObject

/**
 @author Egor Tolstoy
 
 The method returns an NSString with the description of compound operation. It consists of:
 - The general information:
   - The operation class
   - The inner operation queue name
   - Count of operations in the inner queue
   - Maximum concurrent operations number
 - Buffers information:
   - Input data type
   - Input data contents
   - Output data type
   - Output data contents
 - Dependencies on other NSOperations
 - State:
   - The inner queue state
   - The compound operation flags state
 - Additional information:
   - The resultBlock existance
 - Executing suboperations information:
   - Executing suboperation class
   - Executing suboperation debugDescription
 
 @param compoundOperation The provided CompoundOperationBase
 @param internalQueue     The compound operation inner queue
 
 @return Formatted debug description
 */
+ (NSString *)debugDescriptionForCompoundOperation:(CompoundOperationBase *)compoundOperation
                                 withInternalQueue:(NSOperationQueue *)internalQueue;

@end
