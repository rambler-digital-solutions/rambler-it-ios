//
//  RDSModuleTransitionHandlerProtocol.h
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 27/07/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIViewController+Routing/UIViewController+Routing.h>

@protocol RDSModuleConfigurationPromiseProtocol;

@protocol RDSModuleTransitionHandlerProtocol <NSObject>

@optional
- (id<RDSModuleConfigurationPromiseProtocol>)embedModuleWithSegue:(NSString*)segueIdentifier
                                                intoContainerView:(UIView*)containerView
                                                       withSender:(id)sender;
- (UIView*)containerViewWithIdentifier:(NSString*)identifier;
- (void)removeFromParentModule;


- (id<RDSModuleConfigurationPromiseProtocol>)performPromiseSegue:(NSString*)segueIdentifier withSender:(id)sender;


- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;
- (UINavigationController*)navigationController;

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender preparationBlock:(YDPreparationBlock)block;
- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)embedViewController:(UIViewController*)viewController;
- (void)removeViewControllersOfClass:(Class)viewControllerClass;

@end
