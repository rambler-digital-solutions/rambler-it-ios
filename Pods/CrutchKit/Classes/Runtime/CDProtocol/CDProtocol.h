//
//  Protocol+CDExtension.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 07/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDProtocol : NSObject


+ (instancetype)protocolFromObjCProtocol:(Protocol *)protocol;


@property (strong, nonatomic, readonly) Protocol *objcProtocol;


- (NSArray *)selectors;

- (BOOL)isConformsToProtocol:(Protocol *)protocol;

- (BOOL)isEqualToProtocol:(Protocol *)protocol;


+ (BOOL)protocol:(Protocol *)protocol isConformsToProtocol:(Protocol *)other;

+ (BOOL)protocol:(Protocol *)protocol isEqualToProtocol:(Protocol *)other;

+ (BOOL)protocol:(Protocol *)protocol isContainSelector:(SEL)selector recursively:(BOOL)recursively;

@end
