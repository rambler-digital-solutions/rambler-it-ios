//
//  PushNotificationCenter.h
//  Conferences
//
//  Created by Karpushin Artem on 06/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 @author Artem Karpushin
 
 The protocol is designed to manage functional of the push-notifications.
 */
@protocol PushNotificationCenter <NSObject>

/**
 @author Artem Karpushin
 
 The method initiates registration of the application in APNS
 
 @param application UIApplication object
 */
- (void)registerApplicationForPushNotificationsIfNeeded:(UIApplication *)application;

/**
 @author Artem Karpushin
 
 The method is called upon reception of the token by application
 
 @param token Token of the application
 */
- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)token;

/**
 @author Artem Karpushin
 
 The method initiates the processing of incoming push-notification
 
 @param userInfo Push-notificatioin's userInfo dictionary
 @param applicationState State of the application in which the push-notification was obtained
 */
- (void)processPushNotificationWithUserInfo:(NSDictionary *)userInfo applicationState:(UIApplicationState)applicationState;

@end
