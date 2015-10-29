//
//  ServiceComponents.h
//  Conferences
//
//  Created by Karpushin Artem on 07/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TyphoonAssembly.h"

@protocol PushNotificationService;

@protocol ServiceComponents <NSObject>

- (id <PushNotificationService>)pushNotificationService;

@end
