//
//  SystemInfrastructureAssembly.h
//  Conferences
//
//  Created by Karpushin Artem on 04/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TyphoonAssembly.h"

/**
 @author Artem Karpushin
 
 This Assembly is responsible for configuration of the system singletons: NSUserDefaults, NSHTTPCookieStorage, NSNotificationCenter, UIApplication, NSFileManager
 */
@interface SystemInfrastructureAssembly : TyphoonAssembly

- (NSUserDefaults *)userDefaults;
- (NSHTTPCookieStorage *)httpCookieStorage;
- (NSNotificationCenter *)notificationCenter;
- (UIApplication *)application;
- (NSFileManager *)fileManager;

@end
