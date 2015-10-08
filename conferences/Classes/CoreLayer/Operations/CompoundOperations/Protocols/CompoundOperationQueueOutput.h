//
//  CompoundOperationQueueOutput.h
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 The protocol describes an object, capable of processing operation queue output data
 */
@protocol CompoundOperationQueueOutput <NSObject>

/**
 @author Egor Tolstoy
 
 The method setups the operation queue output data.
 */
- (id)obtainOperationQueueOutputData;

@end
