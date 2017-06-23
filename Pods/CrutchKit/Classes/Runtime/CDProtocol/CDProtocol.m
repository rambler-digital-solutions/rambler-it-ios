//
//  Protocol+CDExtension.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 07/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "CDProtocol.h"
#import <objc/runtime.h>
#import "CDSelector.h"

@interface CDProtocol ()

@property (strong, nonatomic, readwrite) Protocol *objcProtocol;

@end

@implementation CDProtocol

- (instancetype)initWithObjCProtocol:(Protocol *)protocol {
    
    self = [super init];
    
    if (self) {
        
        _objcProtocol = protocol;
        
    }
    
    return self;
}

+ (instancetype)protocolFromObjCProtocol:(Protocol *)protocol {
    
    return [[self alloc] initWithObjCProtocol:protocol];
    
}

- (BOOL)isConformsToProtocol:(Protocol *)protocol {
    
     return protocol_conformsToProtocol(self.objcProtocol, protocol);
    
}

- (BOOL)isEqualToProtocol:(Protocol *)protocol {
    
    return protocol_isEqual(self.objcProtocol, protocol);
    
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[CDProtocol class]]) {
        CDProtocol *obj = (CDProtocol *)object;
        return [self isEqualToProtocol:obj.objcProtocol];
    }
    return NO;
}

- (NSArray *)selectors {
    
    static BOOL isReqVals[4] = {NO, NO, YES, YES};
    static BOOL isInstanceVals[4] = {NO, YES, NO, YES};
    
    NSMutableArray *selectors = [NSMutableArray new];
    
    for(int i = 0; i < 4; i++) {
        
        unsigned int count;
        
        struct objc_method_description *methods = protocol_copyMethodDescriptionList(self.objcProtocol,
                                                                                     isReqVals[i],
                                                                                     isInstanceVals[i],
                                                                                     &count);
        for(unsigned i = 0; i < count; i++) {

            CDSelector *selector =[CDSelector selectorWithObjcSelector:methods[i].name
                                                      isRequiredMethod:isReqVals[i]
                                                      isInstanceMethod:isInstanceVals[i]
                                                             objCTypes:methods[i].types];
            [selectors addObject:selector];
        }
        
        free(methods);
    }
    
    return [selectors copy];
}


+ (BOOL)protocol:(Protocol *)protocol isConformsToProtocol:(Protocol *)other {
    
    return protocol_conformsToProtocol(protocol, other);
    
}

+ (BOOL)protocol:(Protocol *)protocol isEqualToProtocol:(Protocol *)other {
    
    return protocol_isEqual(protocol, other);
    
}

+ (BOOL)protocol:(Protocol *)aProtocol isContainSelector:(SEL)aSelector recursively:(BOOL)recursively {
    
    if (recursively) {
        return [self protocol:aProtocol isContainSelector:aSelector];
    }
    
    CDProtocol *protocol = [CDProtocol protocolFromObjCProtocol:aProtocol];
    for (CDSelector *selector in protocol.selectors) {
        if ([CDSelector selector:selector.objcSelector isEqualToSelector:aSelector]) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)protocol:(Protocol *)protocol isContainSelector:(SEL)selector {
    
    static BOOL isReqVals[4] = {NO, NO, YES, YES};
    static BOOL isInstanceVals[4] = {NO, YES, NO, YES};
    struct objc_method_description methodDescription = {NULL, NULL};
    
    for(int i = 0; i < 4; i++) {
        
        methodDescription = protocol_getMethodDescription(protocol,
                                                          selector,
                                                          isReqVals[i],
                                                          isInstanceVals[i]);
        
        if(methodDescription.types != NULL && methodDescription.name != NULL){
            return YES;
        }
    }
    
    return NO;
}

@end
