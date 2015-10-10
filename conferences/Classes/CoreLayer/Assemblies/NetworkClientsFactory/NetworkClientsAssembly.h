//
//  NetworkClientsAssembly.h
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Typhoon/Typhoon.h>

#import "NetworkClientsFactory.h"

/**
 @author Egor Tolstoy
 
 The implementation of the NetworkClientsFactory protocol, based on TyphoonAssembly
 */
@interface NetworkClientsAssembly : TyphoonAssembly <NetworkClientsFactory>

@end
