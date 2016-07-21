//
//  RamblerAppDelegateProxyInjector.h
//  Pods
//
//  RamblerAppDelegateProxy
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Vadim Smal
 
 Object for lazy injection to RamblerAppDelegateProxy
 
 @return instancetype
 */
@interface RamblerAppDelegateProxyInjector : NSProxy

/**
 @author Vadim Smal
 
 Constructor
 
 @return instancetype
 */
- (instancetype)init;

/**
 @author Vadim Smal
 
 Method for apply injection
 
 @param object object for injection (RamblerAppDelegateProxy)
 */
- (void)apply:(id)object;

@end
