//
//  CDObserversProxy.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 07/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "CDObserversProxy.h"
#import "CDProtocol.h"
#import "CDSelector.h"
#import <objc/runtime.h>

@interface CDObserversProxy ()

@property (strong, nonatomic) NSHashTable *observers;
@property (strong, nonatomic, readwrite) Protocol *proxyProtocol;

@end

@implementation CDObserversProxy

- (instancetype)initWithProtocol:(Protocol *)protocol
                       observers:(NSArray *)observers {
    
    self = [super init];
    
    if (self) {
        
        _proxyProtocol = protocol;
        
        _observers = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
        
        for (id observer in observers) {

            [self addObserver:observer];
            
        }
        
    }
    
    return self;
}

+ (instancetype)observersProxyWithProtocol:(Protocol *)protocol
                                 observers:(NSArray *)observers {
    
    return [[self alloc] initWithProtocol:protocol
                                observers:observers];
}

- (BOOL)respondsToSelector:(SEL)selector
              fromProtocol:(Protocol *)protocol
                fromSender:(id)sender {
    return [CDProtocol protocol:self.proxyProtocol isConformsToProtocol:protocol];
}

- (void)addObserver:(id<CDObserver>)observer {
    
    @synchronized(self) {
        
        NSAssert([observer conformsToProtocol:self.proxyProtocol], @"observer %@ not conform to protocol %@", observer, self.proxyProtocol);
        [_observers addObject:observer];
        
    }
    
}

- (void)removeObserver:(id)observer {
    
    @synchronized(self) {
        
        [_observers removeObject:observer];
        
    }
    
}

- (BOOL)respondsToSelector:(SEL)selector {
    @synchronized(self) {
        
        if ([super respondsToSelector:selector]) {
            return YES;
        }
        
        NSArray *observers = [self.observers copy];
        for (id observer in observers) {
            if ([observer respondsToSelector:selector]) {
                return YES;
            }
        }
        
        return NO;
        
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    
    @synchronized(self) {
        
        NSArray *observers = [self.observers copy];
        
        for (id observer in observers) {
            
            if ([observer respondsToSelector:selector]) {
                return [observer methodSignatureForSelector:selector];
            }
            
        }
        
        NSString *reason = [NSString stringWithFormat:@"The observer which respond to %@ has not been found.", NSStringFromSelector(selector)];
        @throw([NSException exceptionWithName:@"CDObserversProxyException" reason:reason userInfo:nil]);
        
        return [super methodSignatureForSelector:@selector(cd_emptySignatureSelector)];
    }
    
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    
    @synchronized(self) {
        
        SEL selector = [invocation selector];
        
        if (![CDProtocol protocol:self.proxyProtocol isContainSelector:selector]) {
            NSLog(@"WARNING : try forward invocation with selector %@ not contained in protocol %@", NSStringFromSelector(selector), NSStringFromProtocol(self.proxyProtocol));
            return;
        }
        
        NSArray *observers = [self.observers copy];
        
        for (id<CDObserver> observer in observers) {
            
            if ([observer respondsToSelector:[invocation selector]]) {
                
                if ([observer respondsToSelector:@selector(wantObserveSelector:)]) {
                    if (![observer wantObserveSelector:[invocation selector]]) {
                        return;
                    }
                }
                
                [invocation invokeWithTarget:observer];
                
                if (self.onlyFirstRespondedObserver) {
                    return;
                }
                
            }
        }
        
    }
}

- (void)cd_emptySignatureSelector {
    
}

@end
