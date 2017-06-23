//
//  UIResponder+CDExtension.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 07/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "UIResponder+CDProxying.h"
#import <objc/runtime.h>
#import "CDProxy.h"
#import "CDProtocol.h"

@interface UIResponder ()

@property (strong, nonatomic, readwrite) id<CDProxy> cd_defaultProxy;

@end

@implementation UIResponder (CDProxying)

@dynamic cd_defaultProxy;

- (id <CDProxy>)cd_defaultProxy {
    return objc_getAssociatedObject(self, @selector(cd_defaultProxy));
}

- (void)setCd_defaultProxy:(id <CDProxy>)proxy {
    objc_setAssociatedObject(self, @selector(cd_defaultProxy), proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)cd_insertProxyInResponderChain:(id<CDProxy>)proxy {
    self.cd_defaultProxy = proxy;
}

- (void)cd_removeProxyFromResponderChain {
    self.cd_defaultProxy = nil;
}

- (id<CDProxy>)cd_proxyForProtocol:(Protocol *)protocol {
    
    NSArray *responderChain = [self cd_responderChain];
    
    for (UIResponder *responder in responderChain) {
        
        id<CDProxy> proxy = responder.cd_defaultProxy;
        
        for (Protocol *responderDefaultProxy in proxy.proxyProtocols) {
            if ([CDProtocol protocol:responderDefaultProxy isConformsToProtocol:protocol]) {
                return proxy;
            }
        }
        
    }
    
    return nil;
}

- (id<CDProxy>)cd_proxyForProtocol:(Protocol *)protocol
                          selector:(SEL)selector {
    NSArray *responderChain = [self cd_responderChain];
    
    for (UIResponder *responder in responderChain) {
        
        id<CDProxy> proxy = responder.cd_defaultProxy;
        
        for (Protocol *responderDefaultProxy in proxy.proxyProtocols) {
            BOOL conformToProtocol = [CDProtocol protocol:responderDefaultProxy
                                     isConformsToProtocol:protocol];
            BOOL respondToSelector = [proxy respondsToSelector:selector
                                                  fromProtocol:protocol
                                                    fromSender:self];
            if (conformToProtocol && respondToSelector) {
                return proxy;
            }
        }
        
    }
    
    return nil;
}

- (NSArray *)cd_responderChain {
    UIResponder *responder = self;
    NSMutableArray *responders = [NSMutableArray arrayWithObject:responder];
    while ((responder = [responder nextResponder]) != nil) {
        [responders addObject:responder];
    }
    return responders;
}

@end
