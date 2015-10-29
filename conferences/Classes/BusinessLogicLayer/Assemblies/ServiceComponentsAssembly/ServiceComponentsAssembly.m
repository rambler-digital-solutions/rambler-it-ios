//
//  ServiceComponentsImplementation.m
//  Conferences
//
//  Created by Karpushin Artem on 07/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ServiceComponentsAssembly.h"
#import "PushNotificationService.h"
#import "PushNotificationServiceImplementation.h"

@implementation ServiceComponentsAssembly

- (id <PushNotificationService>)pushNotificationService {
    return [TyphoonDefinition withClass:[PushNotificationServiceImplementation class]];
}

@end
