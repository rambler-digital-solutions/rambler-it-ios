//
//  UIViewController+CDObserver.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 11/09/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "UIViewController+CDObserver.h"
#import "CDObserversProxy.h"
#import "UIResponder+CDProxying.h"

@implementation UIViewController (CDObserver)

- (void)cd_startObserveProtocol:(Protocol *)protocol {
    [self cd_startObserveProtocols:@[protocol]];
}

- (void)cd_startObserveProtocols:(NSArray *)protocols {
    id<CDProxy> proxy = [CDObserversProxy observersProxyWithProtocols:protocols
                                                            observers:@[self]];
    [self cd_insertProxyInResponderChain:proxy];
}

- (void)cd_stopObserve {
    [self cd_removeProxyFromResponderChain];
}

@end
