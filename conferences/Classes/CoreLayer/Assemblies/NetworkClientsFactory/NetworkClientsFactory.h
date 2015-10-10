//
//  NetworkClientsFactory.h
//  Conferences
//
//  Created by Egor Tolstoy on 05/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkClient;

/**
 @author Egor Tolstoy
 
 The factory is responsible for creating NetworkClients
 */
@protocol NetworkClientsFactory <NSObject>

/**
 @author Egor Tolstoy
 
 The method returns a common NetworkClient
 
 @param type NetworkConnectionType
 
 @return id<NetworkClient>
 */
- (id<NetworkClient>)commonNetworkClient;

@end
