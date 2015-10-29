//
//  PushNotificationService.h
//  Conferences
//
//  Created by Karpushin Artem on 06/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PushNotification;
@class PushSubscriptionModel;

typedef void(^PushNotificationServiceRegistrationCompletionBlock)(NSError *error);
typedef void(^PushNotificationServiceProcessNotificationCompletionBlock)(PushNotification *pushNotification);

/**
 @author Artem Karpushin
 
 
 */
@protocol PushNotificationService <NSObject>

/**
 @author Artem Karpushin
 
 The method is used to add the token of the device to the server
 
 @param token Token of the device
 @param completionBlock The block which called after registration of the push-notification is complete
 */
- (void)registerForPushNotificationsWithToken:(NSData *)token
                              completionBlock:(PushNotificationServiceRegistrationCompletionBlock)completionBlock;
/**
 @author Artem Karpushin
 
 The method mappes userInfo dictionary to data model object
 
 @param userInfo Push-notificatioin's userInfo dictionary
 @param completionBlock The block which called after processing of the push-nitification is complete
 */
- (void)processPushNotificationWithUserInfo:(NSDictionary *)userInfo
                            completionBlock:(PushNotificationServiceProcessNotificationCompletionBlock)completionBlock;

//- (void)unregisterForPushNotifications:completionBlock:

@end
