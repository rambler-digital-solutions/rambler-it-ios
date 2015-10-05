//
//  RequestConfiguratorsFactory.h
//  Conferences
//
//  Created by Egor Tolstoy on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RequestConfigurationType.h"

@protocol RCFRequestConfigurator;

/**
 @author Egor Tolstoy
 
 The factory is responsible for creating RequestConfigurators
 */
@protocol RequestConfiguratorsFactory <NSObject>

/**
 @author Egor Tolstoy
 
 The method returns a proper RequestConfigurator based on a given type
 
 @param type RequestConfigurationType
 
 @return id<RCFRequestConfigurator>
 */
- (id<RCFRequestConfigurator>)requestConfiguratorWithType:(NSNumber *)type;

@end
