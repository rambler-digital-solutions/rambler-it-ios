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
