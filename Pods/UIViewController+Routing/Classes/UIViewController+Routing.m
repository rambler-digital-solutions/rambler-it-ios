//
//  UIViewController+Routing.m
//
//  Created by Egor Tolstoy on 07.02.15.
//  Copyright (c) 2015 Egor Tolstoy. All rights reserved.
//

#import "UIViewController+Routing.h"
#import <objc/runtime.h>

@implementation UIViewController (Routing)

@dynamic router;

#pragma mark - Associated Objects

- (id <YDRouter>)router {
    return objc_getAssociatedObject(self, @selector(router));
}

- (void)setRouter:(id <YDRouter>)router {
    objc_setAssociatedObject(self, @selector(router), router, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)seguesBlockDictionary {
    return objc_getAssociatedObject(self, @selector(seguesBlockDictionary));
}

- (void)setSeguesBlockDictionary:(NSDictionary *)dict {
    objc_setAssociatedObject(self, @selector(seguesBlockDictionary), dict, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - Segues with Preparation Blocks Implementation

- (void)setPreparationBlock:(YDPreparationBlock)block forSegueWithIdentifier:(NSString *)identifier
{
    if (!identifier) {
        return;
    }

    NSMutableDictionary *dict = [[self seguesBlockDictionary]?:@{} mutableCopy];
    if (block) {
        dict[identifier] = [block copy];
    } else {
        [dict removeObjectForKey:identifier];
    }
    
    [self setSeguesBlockDictionary:dict];
}

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender preparationBlock:(YDPreparationBlock)block {
    [self setPreparationBlock:block forSegueWithIdentifier:identifier];
    [self performSegueWithIdentifier:identifier sender:sender];
}

- (YDPreparationBlock)preparationBlockForSegue:(UIStoryboardSegue *)segue
{
    NSDictionary *dict = [self seguesBlockDictionary];
    return dict[segue.identifier];
}

#pragma mark - Methods Swizzling

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(prepareForSegue:sender:);
        SEL swizzledSelector = @selector(yd_prepareForSegue:sender:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)yd_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self yd_prepareForSegue:segue sender:sender];
    
    [self.router prepareForSegue:segue sender:sender];
    [self setPreparationBlock:nil forSegueWithIdentifier:segue.identifier];
}


@end
