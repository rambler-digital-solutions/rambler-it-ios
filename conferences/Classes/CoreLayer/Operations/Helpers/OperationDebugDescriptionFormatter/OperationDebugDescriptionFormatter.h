//
//  OperationDebugDescriptionFormatter.h
//  Conferences
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChainableOperation;

/**
 @author Egor Tolstoy
 
 This object formats the chainable NSOperation description for logging it
 */
@interface OperationDebugDescriptionFormatter : NSObject

/**
 @author Egor Tolstoy
 
 The method returns an NSString with the description of chainable operation. It consists of:
 - The operation class
 - Input data description
 - Dependencies on other operations
 - Operation state (flags)
 - Additional information
 
 @param operation      ChainableOperation
 @param additionalInfo Additional information specific for the provided operation
 
 @return Formatted debug description
 */
+ (NSString *)debugDescriptionForOperation:(NSOperation <ChainableOperation> *)operation
                        withAdditionalInfo:(NSArray *)additionalInfo;

@end
