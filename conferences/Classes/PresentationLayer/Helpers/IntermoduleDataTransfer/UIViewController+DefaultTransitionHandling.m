//
//  UIViewController+DefaultTransitionHandling.m
//  Championat
//
//  Created by Andrey Zarembo-Godzyatsky on 03/08/15.
//  Copyright (c) 2015 Rambler DS. All rights reserved.
//

#import "UIViewController+DefaultTransitionHandling.h"
#import "RDSModuleConfigurationPromise.h"
#import "RDSModuleConfiguratorHolder.h"

@implementation UIViewController (DefaultTransitionHandling)

- (id<RDSModuleConfigurationPromiseProtocol>)default_performPromiseSegue:(NSString*)segueIdentifier withSender:(id)sender {
    RDSModuleConfigurationPromise *promise = [[RDSModuleConfigurationPromise alloc] init];
    [self performSegueWithIdentifier:segueIdentifier sender:@{
                                                              @"sender":sender,
                                                              @"promise":promise
                                                              }];
    return promise;
}

- (void)default_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[NSDictionary class]] && [segue.destinationViewController conformsToProtocol:@protocol(RDSModuleConfiguratorHolder)]) {
        RDSModuleConfigurationPromise * promise = sender[@"promise"];
        [promise setModuleConfigurator:[(id<RDSModuleConfiguratorHolder>)segue.destinationViewController moduleConfigurator]];
    }
}

- (void)default_embedViewController:(UIViewController*)viewController {
    [self addChildViewController:viewController];
    [viewController.view setFrame: self.view.bounds];
    [self.view addSubview: viewController.view];    
}

@end
