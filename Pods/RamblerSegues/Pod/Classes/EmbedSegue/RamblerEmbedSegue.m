//
//  RamblerEmbedSegue.m
//  VIPER McFlurry
//
//  Created by Andrey Zarembo-Godzyatsky on 21/08/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "RamblerEmbedSegue.h"
#import "RamblerEmbedSegueViewContainer.h"

@implementation RamblerEmbedSegue


- (void)perform {
    
    UIViewController<RamblerEmbedSegueViewContainer> *parentViewController = self.sourceViewController;
    UIViewController *embeddableModuleViewController = self.destinationViewController;
    
    if (![parentViewController conformsToProtocol:@protocol(RamblerEmbedSegueViewContainer)]) {
        [[NSException exceptionWithName:@"Embed Segue was called from unsopported View Controller"
                                 reason:@"Embed segue source view controller does not conforms to RamblerViperEmbedModuleContainer protocol"
                               userInfo:nil] raise];
    }
    
    UIView *containerView = [parentViewController viewForEmbedIdentifier:self.identifier];
    
    [parentViewController addChildViewController:embeddableModuleViewController];
    UIView *moduleView = embeddableModuleViewController.view;
    [containerView addSubview:moduleView];
    
    moduleView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[moduleView]-0-|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(moduleView)]];
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[moduleView]-0-|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(moduleView)]];
}

@end
