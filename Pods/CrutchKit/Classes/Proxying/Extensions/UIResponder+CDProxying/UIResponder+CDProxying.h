//
//  UIResponder+CDExtension.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 07/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CDProxy;

@interface UIResponder (CDProxying)

@property (strong, nonatomic, readonly) id<CDProxy> cd_defaultProxy;

- (void)cd_insertProxyInResponderChain:(id<CDProxy>)proxy;

- (void)cd_removeProxyFromResponderChain;

- (id<CDProxy>)cd_proxyForProtocol:(Protocol *)protocol;

- (id<CDProxy>)cd_proxyForProtocol:(Protocol *)protocol
                          selector:(SEL)selector;

- (NSArray *)cd_responderChain;

@end
