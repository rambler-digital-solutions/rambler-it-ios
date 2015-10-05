//
//  ResponseValidatorsAssembly.h
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Typhoon/Typhoon.h>

#import "ResponseValidatorsFactory.h"

/**
 @author Egor Tolstoy
 
 The implementation of the ResponseValidatorsFactory protocol, based on TyphoonAssembly
 */
@interface ResponseValidatorsAssembly : TyphoonAssembly <ResponseValidatorsFactory>

@end
