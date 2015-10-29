//
//  ApplicationAssembly_Testable.h
//  Conferences
//
//  Created by Karpushin Artem on 14/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import "ApplicationAssembly.h"

@class AppDelegate;
@protocol ApplicationConfigurator;
@protocol PushNotificationCenter;
@protocol ThirdPartiesConfigurator;

@interface ApplicationAssembly ()

- (AppDelegate *)appDelegate;
- (id <ApplicationConfigurator>)applicationConfigurator;
- (id <PushNotificationCenter>)pushNotificationCenter;
- (id <ThirdPartiesConfigurator>)thirdPartiesConfigurator;

@end
