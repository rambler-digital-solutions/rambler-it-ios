//
//  CDObserversProxy.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 07/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CDProxy.h"

@protocol CDObserver;

@interface CDObserversProxy : UIResponder <CDProxy>

- (instancetype)initWithProtocol:(Protocol *)protocol
                       observers:(NSArray *)observers;

+ (instancetype)observersProxyWithProtocol:(Protocol *)protocol
                       observers:(NSArray *)observers;

@property (assign, nonatomic) BOOL onlyFirstRespondedObserver;

- (void)addObserver:(id<CDObserver>)observer;
- (void)removeObserver:(id<CDObserver>)observer;

@end

@protocol CDObserver <NSObject>
@optional
- (BOOL)wantObserveSelector:(SEL)selector;

@end
