//
//  CompoundOperationQueueInput.h
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 The protocol describes an object, capable of processing operation queue input data.
 */
@protocol CompoundOperationQueueInput <NSObject>

/**
 @author Egor Tolstoy
 
 The method setups input data for operations queue.
 
 @param inputData The input data can be of any kind (array, dictionary, custom object). Type casting and interpreting are the responsibilities of concrete suboperations.
 */
- (void)setOperationQueueInputData:(id)inputData;

@end
