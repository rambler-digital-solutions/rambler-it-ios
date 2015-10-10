//
//  AsyncOperation.h
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 The base NSOperation class, which provides the asynchronyous capabilities to all of its subclasses.
 */
@interface AsyncOperation : NSOperation

/**
 @author Egor Tolstoy
 
 This method is called in a separate thread after operation start. Should be overriden.
 */
- (void)main;

/**
 @author Egor Tolstoy
 
 This method sets all operation flags to appropriate values. Should be manually called after operation executes.
 */
- (void)complete;

@end
