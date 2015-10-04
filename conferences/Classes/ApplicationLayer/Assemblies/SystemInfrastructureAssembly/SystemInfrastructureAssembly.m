//
//  SystemInfrastructureAssembly.m
//  Conferences
//
//  Created by Karpushin Artem on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "SystemInfrastructureAssembly.h"

@implementation SystemInfrastructureAssembly

- (NSUserDefaults *)userDefaults {
    return [TyphoonDefinition withClass:[NSUserDefaults class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(standardUserDefaults)];
        definition.scope = TyphoonScopeSingleton;
    }];
}

- (NSHTTPCookieStorage *)httpCookieStorage {
    return [TyphoonDefinition withClass:[NSHTTPCookieStorage class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(sharedHTTPCookieStorage)];
        definition.scope = TyphoonScopeSingleton;
    }];
}

- (NSNotificationCenter *)notificationCenter {
    return [TyphoonDefinition withClass:[NSNotificationCenter class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(defaultCenter)];
        definition.scope = TyphoonScopeSingleton;
    }];
}

- (UIApplication *)application {
    return [TyphoonDefinition withClass:[UIApplication class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(sharedApplication)];
        definition.scope = TyphoonScopeSingleton;
    }];
}

- (NSFileManager *)fileManager {
    return [TyphoonDefinition withClass:[NSFileManager class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(defaultManager)];
        definition.scope = TyphoonScopeSingleton;
    }];
}


@end
