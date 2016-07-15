//
//  RootControllerAppDelegate.m
//  Conferences
//
//  Created by k.zinovyev on 15.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "RootControllerAppDelegate.h"

static NSString *const kMainStoryboardName = @"Main";
static NSString *const kMainStartTabBarViewControllerName = @"StartTabBarController";
@implementation RootControllerAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kMainStoryboardName bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:kMainStartTabBarViewControllerName];
    window.rootViewController = vc;
    [window makeKeyAndVisible];

    return YES;
}

@end
