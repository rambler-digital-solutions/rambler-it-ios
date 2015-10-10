//
//  RequestConfiguratorsAssembly.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Typhoon/Typhoon.h>

#import "RequestConfiguratorsFactory.h"

/**
 @author Egor Tolstoy
 
 The implementation of the RequestConfiguratorsFactory protocol, based on TyphoonAssembly
 */
@interface RequestConfiguratorsAssembly : TyphoonAssembly <RequestConfiguratorsFactory>

@end
