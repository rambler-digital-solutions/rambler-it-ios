//
//  CDSelector.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 09/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDSelector : NSObject

+ (instancetype)selectorWithObjcSelector:(SEL)objcSelector
                        isRequiredMethod:(BOOL)isRequiredMethod
                        isInstanceMethod:(BOOL)isInstanceMethod
                               objCTypes:(const char *)types;

@property (assign, nonatomic, readonly) BOOL isRequiredMethod;
@property (assign, nonatomic, readonly) BOOL isInstanceMethod;
@property (assign, nonatomic, readonly) SEL objcSelector;
@property (strong, nonatomic, readonly) NSMethodSignature *signature;

+ (BOOL)selector:(SEL)selector
 isEqualToSelector:(SEL)other;

@end
