//
//  RamblerAppDelegateProxyInjector.m
//  Pods
//
//  RamblerAppDelegateProxy
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "RamblerAppDelegateProxyInjector.h"
#import "RamblerAppDelegateProxyProtocol.h"
#import <objc/runtime.h>

@interface RamblerAppDelegateProxyInjector ()

@property (strong, nonatomic) NSMutableArray *invocations;

@end

@implementation RamblerAppDelegateProxyInjector

- (instancetype)init {
    _invocations = [NSMutableArray new];
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    struct { BOOL isRequired; BOOL isInstance; } opts[4] = { {YES, YES}, {NO, YES}, {YES, NO}, {NO, NO} };
    for(int i = 0; i < 4; i++)
    {
        struct objc_method_description methodDescription = protocol_getMethodDescription(@protocol(RamblerAppDelegateProxyProtocol), aSelector, opts[i].isRequired, opts[i].isInstance);
        if(methodDescription.name != NULL)
            return [NSMethodSignature signatureWithObjCTypes:methodDescription.types];
    }
    return nil;
    
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation retainArguments];
    [self.invocations addObject:anInvocation];
}

- (void)apply:(id)object {
    for (NSInvocation *invocation in self.invocations) {
        [invocation invokeWithTarget:object];
    }
    [self.invocations removeAllObjects];
}

@end
