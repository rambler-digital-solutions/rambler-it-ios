//
//  AppDelegate.m
//  Conferences
//
//  Created by Egor Tolstoy on 30/09/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "AppDelegate.h"

#import "ApplicationConfigurator.h"
#import "PushNotificationCenter.h"
#import "ThirdPartiesConfigurator.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self.thirdPartiesConfigurator configurate];
    [self.applicationConfigurator setupCoreDataStack];
    [self.pushNotificationCenter registerApplicationForPushNotificationsIfNeeded:application];
    
    NSDictionary *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (notification) {
        [self.pushNotificationCenter processPushNotificationWithUserInfo:notification
                                                        applicationState:application.applicationState];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [self.pushNotificationCenter didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [self.pushNotificationCenter processPushNotificationWithUserInfo:userInfo
                                                    applicationState:application.applicationState];
}

@end
