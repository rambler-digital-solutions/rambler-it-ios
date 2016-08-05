//
//  CDSelector.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 09/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "CDSelector.h"
#import <objc/runtime.h>

@interface CDSelector ()

@property (assign, nonatomic, readwrite) BOOL isRequiredMethod;
@property (assign, nonatomic, readwrite) BOOL isInstanceMethod;
@property (assign, nonatomic, readwrite) SEL objcSelector;
@property (strong, nonatomic, readwrite) NSMethodSignature *signature;

@end

@implementation CDSelector

- (instancetype)initFromObjcSelector:(SEL)objCSelector
                    isRequiredMethod:(BOOL)isRequiredMethod
                    isInstanceMethod:(BOOL)isInstanceMethod
                           objCTypes:(const char *)types {
    
    self = [super init];
    if (self) {
        _objcSelector = objCSelector;
        _isRequiredMethod = isRequiredMethod;
        _isInstanceMethod = isInstanceMethod;
        _signature = [NSMethodSignature signatureWithObjCTypes:types];
    }
    return self;
}

+ (instancetype)selectorWithObjcSelector:(SEL)objcSelector
                        isRequiredMethod:(BOOL)isRequiredMethod
                        isInstanceMethod:(BOOL)isInstanceMethod
                               objCTypes:(const char *)types{
    
    return [[self alloc] initFromObjcSelector:objcSelector
                             isRequiredMethod:isRequiredMethod
                             isInstanceMethod:isInstanceMethod
                                    objCTypes:types];
    
}

+ (BOOL)selector:(SEL)selector isEqualToSelector:(SEL)other {
    return sel_isEqual(selector, other);
}

- (BOOL)isEqual:(CDSelector *)object {
    
    if (![object isKindOfClass:[CDSelector class]]) {
        return NO;
    }
    
    BOOL equalSelector = sel_isEqual(self.objcSelector, object.objcSelector);
    BOOL equalSignature = [self.signature isEqual:object.signature];
    BOOL equalIsRequiredMethod = self.isRequiredMethod == object.isRequiredMethod;
    BOOL equalIsInstanceMethod = self.isInstanceMethod == object.isInstanceMethod;
    
    return equalSelector && equalSignature && equalIsRequiredMethod && equalIsInstanceMethod;
}

@end
