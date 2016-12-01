//
//  UberRidesAppDelegate.m
//  Conferences
//
//  Created by s.sarkisyan on 01.12.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "UberRidesAppDelegate.h"

#import <UberRides/UberRides.h>

@implementation UberRidesAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UBSDKConfiguration setRegion:RegionDefault];
    
    [UBSDKConfiguration setSandboxEnabled:YES];
    
    [UBSDKConfiguration setFallbackEnabled:NO];
    
    return YES;
}

@end
