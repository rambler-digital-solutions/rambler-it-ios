//
//  AppDelegate.h
//  Conferences
//
//  Created by Egor Tolstoy on 30/09/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@protocol ApplicationConfigurator;
@protocol PushNotificationCenter;
@protocol ThirdPartiesConfigurator;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) id <ApplicationConfigurator> applicationConfigurator;
@property (strong, nonatomic) id <PushNotificationCenter> pushNotificationCenter;
@property (strong, nonatomic) id <ThirdPartiesConfigurator> thirdPartiesConfigurator;

@end

