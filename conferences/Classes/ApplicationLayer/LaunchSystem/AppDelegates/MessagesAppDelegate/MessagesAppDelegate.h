//
//  MessagesAppDelegate.h
//  Conferences
//
//  Created by Trishina Ekaterina on 27/10/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LaunchHandler;
@class MessagesUserActivityFactory;

/**
 @author Trishina Ekaterina

 This AppDelegate is responsible for handling application open from iMessage App
 */
@interface MessagesAppDelegate : NSObject <UIApplicationDelegate>

- (instancetype)initWithLaunchHandlers:(NSArray <id<LaunchHandler>> *)launchHandlers
                   userActivityFactory:(MessagesUserActivityFactory *)userActivityFactory;

@end
