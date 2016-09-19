//
//  RamblerAppDelegateProxy.h
//  Pods
//
//  RamblerAppDelegateProxy
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "RamblerAppDelegateProxyProtocol.h"

/**
 @author Vadim Smal
 
 Proxy for AppDelegate class replacement.
 */
@interface RamblerAppDelegateProxy : NSProxy <RamblerAppDelegateProxyProtocol>

/**
 @author Vadim Smal
 
 Constructor
 
 @return instancetype
 */
- (instancetype)init;

/**
 @author Vadim Smal
 
 Dependency injection container
 
 @return RamblerAppDelegateProxyInjector
 */
+ (instancetype)injector;

@end
