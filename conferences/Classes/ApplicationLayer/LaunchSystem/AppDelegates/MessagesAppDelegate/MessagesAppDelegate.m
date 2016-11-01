//
//  MessagesAppDelegate.m
//  Conferences
//
//  Created by Trishina Ekaterina on 27/10/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "MessagesAppDelegate.h"

#import "LaunchHandler.h"
#import "MessagesUserActivityFactory.h"

@interface MessagesAppDelegate ()

@property (nonatomic, strong) NSArray<id<LaunchHandler>> *launchHandlers;
@property (nonatomic, strong) MessagesUserActivityFactory *userActivityFactory;

@end

@implementation MessagesAppDelegate

#pragma mark - Initialization

- (instancetype)initWithLaunchHandlers:(NSArray <id<LaunchHandler>> *)launchHandlers
                   userActivityFactory:(MessagesUserActivityFactory *)userActivityFactory {
    self = [super init];
    if (self) {
        _launchHandlers = launchHandlers;
        _userActivityFactory = userActivityFactory;
    }
    return self;
}

#pragma mark - <UIApplicationDelegate>

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    NSUserActivity *activity = [self.userActivityFactory createUserActivityFromURL:url];
    for (id<LaunchHandler> launchHandler in self.launchHandlers) {
        if ([launchHandler canHandleLaunchWithActivity:activity]) {
            [launchHandler handleLaunchWithActivity:activity];
            return YES;
        }
    }
    return NO;
}

@end
