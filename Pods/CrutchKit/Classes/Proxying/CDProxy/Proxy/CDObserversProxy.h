//
//  CDObserversProxy.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 07/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDProxy.h"

@protocol CDObserver;
@class CDProxyDefinition;

@interface CDObserversProxy : UIResponder <CDProxy>

- (instancetype)initWithDefinition:(CDProxyDefinition *)definition;

+ (instancetype)observersProxyWithDefinition:(CDProxyDefinition *)definition;

- (instancetype)initWithProtocol:(Protocol *)protocol
                       observers:(NSArray *)observers;

+ (instancetype)observersProxyWithProtocol:(Protocol *)protocol
                       observers:(NSArray *)observers;

- (instancetype)initWithProtocols:(NSArray *)protocols
                        observers:(NSArray *)observers;

+ (instancetype)observersProxyWithProtocols:(NSArray *)protocols
                                  observers:(NSArray *)observers;

+ (instancetype)observersProxyForSender:(UIResponder *)sender
                               protocol:(Protocol *)protocol;



- (void)addObserver:(id<CDObserver>)observer;
- (void)removeObserver:(id<CDObserver>)observer;

@end
