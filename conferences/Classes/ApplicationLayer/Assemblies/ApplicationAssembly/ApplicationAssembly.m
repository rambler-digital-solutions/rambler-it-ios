//
//  ApplicationAssembly.m
//  Conferences
//
//  Created by Karpushin Artem on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ApplicationAssembly.h"

#import "ApplicationConfigurator.h"
#import "ApplicationConfiguratorImplementation.h"
#import "AppDelegate.h"

@implementation ApplicationAssembly

- (AppDelegate *)appDelegate {
    return [TyphoonDefinition withClass:[AppDelegate class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(applicationConfigurator) with:[self applicationConfigurator]];
    }];
}

- (id <ApplicationConfigurator>)applicationConfigurator {
    return [TyphoonDefinition withClass:[ApplicationConfiguratorImplementation class]];
}

@end
