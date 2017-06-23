//
//  CDProxyDefinition.h
//  Pods
//
//  Created by Smal Vadim on 15/12/15.
//
//

#import <Foundation/Foundation.h>

@protocol CDObserver;

@interface CDProxyDefinition : NSObject

+ (instancetype)definitionWithProtocols:(NSArray *)protocols;

+ (instancetype)definitionWithProtocols:(NSArray *)protocols
                              observers:(NSArray *)observers;

@property (assign, nonatomic) BOOL onlyFirstRespondedObserver;

- (NSArray *)proxyObservers;
- (NSArray *)proxyProtocols;

- (void)addObserver:(id<CDObserver>)observer;

- (void)removeObserver:(id<CDObserver>)observer;

@end
