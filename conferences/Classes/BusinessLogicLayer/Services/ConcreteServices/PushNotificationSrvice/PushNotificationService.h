// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
