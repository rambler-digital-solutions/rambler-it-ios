//
//  PushNotificationCenterImplementation.m
//  Conferences
//
//  Created by Karpushin Artem on 06/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "PushNotificationCenterImplementation.h"
#import "EXTScope.h"

@implementation PushNotificationCenterImplementation

- (void)registerApplicationForPushNotificationsIfNeeded:(UIApplication *)application {
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }
}

- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)token {
    @weakify(self);
    [self.pushNotificationService registerForPushNotificationsWithToken:token completionBlock:^(NSError *error) {
        @strongify(self);
        
    }];
    
}

- (void)processPushNotificationWithUserInfo:(NSDictionary *)userInfo applicationState:(UIApplicationState)applicationState {
    @weakify(self);
    [self.pushNotificationService processPushNotificationWithUserInfo:userInfo completionBlock:^(PushNotification *pushNotification) {
        @strongify(self);
        
    }];
}

@end
