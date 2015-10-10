//
//  ChainableOperationDelegate.h
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 The chainable operation delegate
 */
@protocol ChainableOperationDelegate <NSObject>

/**
 @author Egor Tolstoy
 
 The method tells a compound operation (usually it poses as the delegate) that the operation is finished (either successfully, or with an error).
 
 @param error The error, produced either by operation or by its dependencies.
 */
- (void)didCompleteChainableOperationWithError:(NSError *)error;

@end
