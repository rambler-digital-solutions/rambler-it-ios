//
//  NetworkClientsFactory.h
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NetworkConnectionType.h"

@protocol RCFNetworkClient;

/**
 @author Egor Tolstoy
 
 The factory is responsible for creating NetworkClients
 */
@protocol NetworkClientsFactory <NSObject>

/**
 @author Egor Tolstoy
 
 The method returns a proper NetworkClient based on a given type
 
 @param type NetworkConnectionType
 
 @return id<NetworkClient>
 */
- (id<RCFNetworkClient>)clientWithType:(NSNumber *)type;

@end
