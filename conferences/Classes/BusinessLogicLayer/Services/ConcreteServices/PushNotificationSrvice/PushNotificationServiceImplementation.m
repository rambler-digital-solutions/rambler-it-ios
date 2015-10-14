//
//  PushNotificationServiceImplementation.m
//  Conferences
//
//  Created by Karpushin Artem on 06/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "PushNotificationServiceImplementation.h"

#import <Parse/Parse.h>

@implementation PushNotificationServiceImplementation

#pragma mark - Public methods

- (void)registerForPushNotificationsWithToken:(NSData *)token completionBlock:(PushNotificationServiceRegistrationCompletionBlock)completionBlock {
    PFInstallation *installation = [self obtainCurrentInstallation];
    
    [installation setDeviceTokenFromData:token];
    
    [self saveInstallation:installation withBlock:completionBlock];
}

- (void)processPushNotificationWithUserInfo:(NSDictionary *)userInfo completionBlock:(PushNotificationServiceProcessNotificationCompletionBlock)completionBlock {
    
}

#pragma mark - Private methods

- (PFInstallation *)obtainCurrentInstallation {
    PFInstallation *installation = [PFInstallation currentInstallation];
    return installation;
}

- (void)saveInstallation:(PFInstallation *)installation withBlock:(PushNotificationServiceRegistrationCompletionBlock)block {
    [installation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!block) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(error);
        });
    }];
}

@end
