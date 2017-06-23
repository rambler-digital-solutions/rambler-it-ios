//
//  RamblerAppDelegateProxy.m
//  Pods
//
//  RamblerAppDelegateProxy
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "RamblerAppDelegateProxy.h"
#import "RamblerDefaultAppDelegate.h"
#import "RamblerAppDelegateProxyInjector.h"

#import <objc/runtime.h>

@interface RamblerAppDelegateProxy ()

@property (strong, nonatomic) NSMutableArray *delegates;

@end

@implementation RamblerAppDelegateProxy

@synthesize defaultAppDelegate = _defaultAppDelegate;

- (instancetype)init {
    _delegates = [NSMutableArray new];
    [(RamblerAppDelegateProxyInjector *)[[self class] injector] apply:self];
    return self;
}

+ (instancetype)injector {
    static id injector;
    if (!injector) {
        injector = [[RamblerAppDelegateProxyInjector alloc] init];
    }
    return injector;
}

- (UIResponder<UIApplicationDelegate> *)defaultAppDelegate {
    if (!_defaultAppDelegate) {
        _defaultAppDelegate = [RamblerDefaultAppDelegate new];
    }
    return _defaultAppDelegate;
}

- (void)addAppDelegate:(id<UIApplicationDelegate>)delegate {
    if ([delegate conformsToProtocol:@protocol(UIApplicationDelegate)]) {
        [self.delegates addObject:delegate];
    } else {
        [NSException raise:NSInvalidArgumentException
                    format:@"Delegate %@ doesn't conform to protocol UIApplicationDelegate", delegate];
    }
}

- (void)addAppDelegates:(NSArray *)delegates {
    for (id delegate in delegates) {
        [self addAppDelegate:delegate];
    }
}

- (BOOL)respondsToSelector:(SEL)selector {
    
    if ([self shouldForwardToSelf:selector]) {
        return YES;
    }
    
    if ([self shouldForwardToDelegatesSelector:selector]) {
        for (id target in self.delegates) {
            if ([target respondsToSelector:selector]) {
                return YES;
            }
        }
    }
    
    return [self.defaultAppDelegate respondsToSelector:selector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.defaultAppDelegate methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    
    SEL selector = [invocation selector];
    
    if ([self shouldForwardToSelf:selector]) {
        [invocation invokeWithTarget:self];
    }
    
    BOOL hasResponder = NO;
    
    if ([self shouldForwardToDelegatesSelector:selector]) {
        for (id target in self.delegates) {
            if ([target respondsToSelector:selector]) {
                [invocation invokeWithTarget:target];
                hasResponder = YES;
            }
        }
    }
    
    if (hasResponder) return;
    [invocation invokeWithTarget:self.defaultAppDelegate];
}

- (BOOL)shouldForwardToDelegatesSelector:(SEL)selector {
    
    if ([self isSelector:selector fromProtocol:@protocol(UIApplicationDelegate)] && ![self isSelector:selector fromProtocol:@protocol(NSObject)]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isSelector:(SEL)selector fromProtocol:(Protocol *)protocol {
    
    static BOOL isReqVals[4] = {NO, NO, YES, YES};
    static BOOL isInstanceVals[4] = {NO, YES, NO, YES};
    struct objc_method_description methodDescription;
    
    for(int i = 0; i < 4; i++) {
        methodDescription = protocol_getMethodDescription(protocol,
                                                          selector,
                                                          isReqVals[i],
                                                          isInstanceVals[i]);
        
        if(methodDescription.types != NULL && methodDescription.name != NULL){
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)shouldForwardToSelf:(SEL)selector {
    return  sel_isEqual(selector, @selector(addAppDelegate:)) ||
    sel_isEqual(selector, @selector(addAppDelegates:));
}


@end
