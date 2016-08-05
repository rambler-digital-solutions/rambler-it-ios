//
//  UIApplication+CDProxying.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 07/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CDInjectBlock)(id proxy);

@protocol CDProxy;

@interface UIApplication (CDProxying)

- (id<CDProxy>)observersProxyForProtocol:(Protocol *)protocol
                               forSender:(UIResponder *)sender;

- (id<CDProxy>)observersProxyForProtocol:(Protocol *)protocol
                                selector:(SEL)selector
                               forSender:(UIResponder *)sender;

@end
