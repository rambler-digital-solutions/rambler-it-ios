//
//  RamblerAppDelegateProxyProtocol.h
//  Pods
//
//  RamblerAppDelegateProxy
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RamblerAppDelegateProxyProtocol <UIApplicationDelegate>

/**
 @author Vadim Smal
 
 Default AppDelegate for forwarding UIResponder methods and other methods not implemented in array of <UIApplicationDelegate>. If the property is not specified, then RamblerDefaultAppDelegate instance will be lazily initialized.
 */
@property (strong, nonatomic) UIResponder<UIApplicationDelegate> *defaultAppDelegate;
/**
 @author Vadim Smal
 
 Insert object for forwarding UIApplicationDelegate methods.
 Object should conform to UIApplicationDelegate protocol, otherwise it throws exception.
 
 @param delegate <UIApplicationDelegate> object
 */
- (void)addAppDelegate:(id<UIApplicationDelegate>)delegate;

/**
 @author Vadim Smal
 
 Add an array of <UIApplicationDelegate> for forwarding UIApplicationDelegate methods.
 
 @param delegates Array of <UIApplicationDelegate> objects
 */
- (void)addAppDelegates:(NSArray<id <UIApplicationDelegate>> *)delegates;

@end
