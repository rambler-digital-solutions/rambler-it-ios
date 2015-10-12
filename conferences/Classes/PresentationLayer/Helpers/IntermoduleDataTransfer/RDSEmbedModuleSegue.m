//
//  RDSEmbedModuleSegue.m
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 21/08/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "RDSEmbedModuleSegue.h"

@implementation RDSEmbedModuleSegue


- (void)perform {
    
    UIViewController *parentViewController = self.sourceViewController;
    UIViewController *embeddableModuleViewController = self.destinationViewController;

    for (UIView *childView in [self.containerView.subviews copy]) {
        for (UIViewController* childViewController in [parentViewController.childViewControllers copy]) {
            if (childViewController.view == childView) {
                [childView removeFromSuperview];
                [childViewController removeFromParentViewController];
            }
        }
    }
    
    
    [parentViewController addChildViewController:embeddableModuleViewController];
    
    UIView *moduleView = embeddableModuleViewController.view;
    moduleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview: moduleView];
    
    

    // align moduleView from the left and right
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[moduleView]-0-|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:NSDictionaryOfVariableBindings(moduleView)]];
    
    // align moduleView from the top and bottom
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[moduleView]-0-|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:NSDictionaryOfVariableBindings(moduleView)]];
}

@end
