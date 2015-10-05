//
//  ResponseValidatorsFactory.h
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ResponseValidationType.h"

@protocol RCFResponseValidator;

/**
 @author Egor Tolstoy
 
 The factory is responsible for creating ResponseValidators
 */
@protocol ResponseValidatorsFactory <NSObject>

/**
 @author Egor Tolstoy
 
 The method returns a proper ResponseValidator based on a given type
 
 @param type ResponseValidationType
 
 @return id<ResponseValidator>
 */
- (id<RCFResponseValidator>)validatorWithType:(NSNumber *)type;

@end
