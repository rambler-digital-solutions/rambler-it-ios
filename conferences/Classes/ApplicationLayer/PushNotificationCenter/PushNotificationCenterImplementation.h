//
//  PushNotificationCenterImplementation.h
//  Conferences
//
//  Created by Karpushin Artem on 06/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PushNotificationCenter.h"
#import "PushNotificationService.h"

@interface PushNotificationCenterImplementation : NSObject <PushNotificationCenter>

@property (strong, nonatomic) id <PushNotificationService> pushNotificationService;

@end
