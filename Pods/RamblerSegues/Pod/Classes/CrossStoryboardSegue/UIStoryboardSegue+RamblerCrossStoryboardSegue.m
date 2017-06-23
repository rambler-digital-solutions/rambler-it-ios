//
//  UIStoryboardSegue+RamblerCrossStoryboardSegue.m
//  Pods
//
//  Created by Andrey Zarembo-Godzyatsky on 25/09/15.
//
//

#import "UIStoryboardSegue+RamblerCrossStoryboardSegue.h"
#import <objc/runtime.h>
#import "RamblerPlaceholderViewController.h"

static IMP originalDestinationViewControllerMethodImp;

@interface UIStoryboardSegue()

@property (nonatomic,strong) id replacedDestinationViewController;

@end

@implementation UIStoryboardSegue (RamblerCrossStoryboardSegue)

+ (void)initialize {
    [self swizzleDestinationViewControllerMethod];
}

+ (void)swizzleDestinationViewControllerMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        IMP ramblerdestinationViewControllerImp = (IMP)RamblerDestinationViewController;
    
        Method destinationViewControllerMethod = class_getInstanceMethod([self class], @selector(destinationViewController));
        originalDestinationViewControllerMethodImp = method_setImplementation(destinationViewControllerMethod, ramblerdestinationViewControllerImp);
    });
}

id RamblerDestinationViewController(UIStoryboardSegue *self, SEL selector) {
    
    id resultDestinationViewController = ((id(*)(id,SEL))originalDestinationViewControllerMethodImp)(self,selector);
    if (![resultDestinationViewController isKindOfClass:[RamblerPlaceholderViewController class]]) {
        return resultDestinationViewController;
    }
    
    if (self.replacedDestinationViewController == nil) {
        RamblerPlaceholderViewController *placeholderViewController = resultDestinationViewController;
        self.replacedDestinationViewController = placeholderViewController.destinationViewControllerForSegue;
    }
    return self.replacedDestinationViewController;
}

- (id)replacedDestinationViewController {
    return objc_getAssociatedObject(self, @selector(replacedDestinationViewController));
}

- (void)setReplacedDestinationViewController:(id)replacedDestinationViewController {
    objc_setAssociatedObject(self,
                             @selector(replacedDestinationViewController),
                             replacedDestinationViewController,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
