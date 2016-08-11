//
//  UIViewController+RamblerViperModuleTransitionHandlerProtocol.m
//  ViperMcFlurry
//
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "UIViewController+RamblerViperModuleTransitionHandlerProtocol.h"
#import <objc/runtime.h>
#import "RamblerViperOpenModulePromise.h"
#import "RamblerViperModuleFactory.h"

static IMP originalPrepareForSegueMethodImp;

@protocol TranditionalViperViewWithOutput <NSObject>
- (id)output;
@end


@implementation UIViewController (RamblerViperModuleTransitionHandlerProtocol)

#pragma mark - RamblerViperModuleTransitionHandlerProtocol

+ (void)initialize {
    [self swizzlePrepareForSegue];
}

- (id)moduleInput {
    id result = objc_getAssociatedObject(self, @selector(moduleInput));
    if (result == nil && [self respondsToSelector:@selector(output)]) {
        result = [(id<TranditionalViperViewWithOutput>)self output];
    }
    return result;
}

- (void)setModuleInput:(id<RamblerViperModuleInput>)moduleInput {
    objc_setAssociatedObject(self, @selector(moduleInput), moduleInput, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Performs segue without any actions, useful for unwind segues
- (void)performSegue:(NSString *)segueIdentifier {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:segueIdentifier sender:nil];
    });
}

// Method opens module using segue
- (RamblerViperOpenModulePromise*)openModuleUsingSegue:(NSString*)segueIdentifier {
    RamblerViperOpenModulePromise *openModulePromise = [[RamblerViperOpenModulePromise alloc] init];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:segueIdentifier sender:openModulePromise];
    });
    return openModulePromise;
}

// Method opens module using module factory
- (RamblerViperOpenModulePromise*)openModuleUsingFactory:(id <RamblerViperModuleFactoryProtocol>)moduleFactory withTransitionBlock:(ModuleTransitionBlock)transitionBlock {
    RamblerViperOpenModulePromise *openModulePromise = [[RamblerViperOpenModulePromise alloc] init];
    id<RamblerViperModuleTransitionHandlerProtocol> destinationModuleTransitionHandler = [moduleFactory instantiateModuleTransitionHandler];
    id<RamblerViperModuleInput> moduleInput = nil;
    if ([destinationModuleTransitionHandler respondsToSelector:@selector(moduleInput)]) {
        moduleInput = [destinationModuleTransitionHandler moduleInput];
    }

    openModulePromise.moduleInput = moduleInput;
    if (transitionBlock != nil) {
        openModulePromise.postLinkActionBlock = ^{
            transitionBlock(self,destinationModuleTransitionHandler);
        };
    }
    return openModulePromise;
}
// Method removes/closes module
- (void)closeCurrentModule:(BOOL)animated {
    BOOL isInNavigationStack = [self.parentViewController isKindOfClass:[UINavigationController class]];
    BOOL hasManyControllersInStack = isInNavigationStack ? ((UINavigationController *)self.parentViewController).childViewControllers.count > 1 : NO;

    if (isInNavigationStack && hasManyControllersInStack) {
        UINavigationController *navigationController = (UINavigationController*)self.parentViewController;
        [navigationController popViewControllerAnimated:animated];
    }
    else if (self.presentingViewController) {
        [self dismissViewControllerAnimated:animated completion:nil];
    }
    else if (self.view.superview != nil){
        [self removeFromParentViewController];
        [self.view removeFromSuperview];
    }
}

#pragma mark - PrepareForSegue swizzling

+ (void)swizzlePrepareForSegue {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        IMP reamplerPrepareForSegueImp = (IMP)RamblerViperPrepareForSegueSender;

        Method prepareForSegueMethod = class_getInstanceMethod([self class], @selector(prepareForSegue:sender:));
        originalPrepareForSegueMethodImp = method_setImplementation(prepareForSegueMethod, reamplerPrepareForSegueImp);
    });
}

void RamblerViperPrepareForSegueSender(id self, SEL selector, UIStoryboardSegue * segue, id sender) {

    ((void(*)(id,SEL,UIStoryboardSegue*,id))originalPrepareForSegueMethodImp)(self,selector,segue,sender);

    if (![sender isKindOfClass:[RamblerViperOpenModulePromise class]]) {
        return;
    }

    id<RamblerViperModuleInput> moduleInput = nil;

    UIViewController *destinationViewController = segue.destinationViewController;
    if ([destinationViewController isKindOfClass:[UINavigationController class]]) {
      UINavigationController *navigationController = segue.destinationViewController;
      destinationViewController = navigationController.topViewController;
    }

    id<RamblerViperModuleTransitionHandlerProtocol> targetModuleTransitionHandler = destinationViewController;
    if ([targetModuleTransitionHandler respondsToSelector:@selector(moduleInput)]) {
        moduleInput = [targetModuleTransitionHandler moduleInput];
    }

    RamblerViperOpenModulePromise *openModulePromise = sender;
    openModulePromise.moduleInput = moduleInput;
}

@end
