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
#import "PushNotificationCenter.h"
#import "PushNotificationCenterImplementation.h"
#import "ServiceComponents.h"
#import "ThirdPartiesConfigurator.h"
#import "ThirdPartiesConfiguratorImplementation.h"

@implementation ApplicationAssembly

- (AppDelegate *)appDelegate {
    return [TyphoonDefinition withClass:[AppDelegate class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(applicationConfigurator)
                                                    with:[self applicationConfigurator]];
                              [definition injectProperty:@selector(pushNotificationCenter)
                                                    with:[self pushNotificationCenter]];
                              [definition injectProperty:@selector(thirdPartiesConfigurator)
                                                    with:[self thirdPartiesConfigurator]];
    }];
}

- (id <ApplicationConfigurator>)applicationConfigurator {
    return [TyphoonDefinition withClass:[ApplicationConfiguratorImplementation class]];
}

- (id <PushNotificationCenter>)pushNotificationCenter {
    return [TyphoonDefinition withClass:[PushNotificationCenterImplementation class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(pushNotificationService)
                                                    with:[self.serviceComponents pushNotificationService]];
    }];
}

- (id <ThirdPartiesConfigurator>)thirdPartiesConfigurator {
    return [TyphoonDefinition withClass:[ThirdPartiesConfiguratorImplementation class]];
}

@end
