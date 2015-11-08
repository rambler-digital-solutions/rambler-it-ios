//
//  UIApplication+CDProxying.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 07/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "UIApplication+CDProxying.h"
#import "UIResponder+CDProxying.h"
#import "CDProxy.h"

@implementation UIApplication (CDProxying)

- (id <CDProxy>)observersProxyForProtocol:(Protocol *)protocol
                                       selector:(SEL)selector
                                      forSender:(UIResponder *)sender {
    
    NSArray *responderChain = [sender cd_responderChain];
    
    for (UIResponder *responder in responderChain) {
        
        id<CDProxy> proxy = responder.cd_defaultProxy;
        
        if (proxy && [proxy respondsToSelector:selector fromProtocol:protocol fromSender:sender]) {
            return proxy;
        }
        
    }
    
    return nil;
}

@end
