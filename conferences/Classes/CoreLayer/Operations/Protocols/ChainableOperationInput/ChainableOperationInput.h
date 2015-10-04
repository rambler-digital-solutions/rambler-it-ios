//
//  ChainableOperationInput.h
//  Conferences
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^ChainableOperationInputTypeValidationBlock)(id data);

/**
 @author Egor Tolstoy
 
 Протокол источника данных операции
 */
/**
 @author Egor Tolstoy
 
 The protocol for the operation input data source
 */
@protocol ChainableOperationInput <NSObject>

/**
 @author Egor Tolstoy
 
 This method returns input data (if there is any) for the operation execution
 
 @param block The data type validation block
 
 @return Data of any kind, that has passed the validation process
 */
- (id)obtainInputDataWithTypeValidationBlock:(ChainableOperationInputTypeValidationBlock)block;

@end
