### Overview

**RamblerAppDelegateProxy** is your best cure against massive `AppDelegate` class. It provides a nice and clean way to divide all of the `AppDelegate` responsibilities between multiple helper classes.

![Picture](http://www.androidphone.su/wp-content/uploads/2015/09/aaazaaa.png)

Just imagine, that instead of 2k lines of code monster you have multiple simple classes:

- `StartAppDelegate` - configures application on start up,
- `AnalyticsAppDelegate` - configures analytics services,
- `RemoteNotificationAppDelegate` - handles push-notifications,
- `SpotlightAppDelegate` - handles start from spotlight results,
- `HandoffAppDelegate` - handles start from handoff,
- `DeepLinkAppDelegate` - incapsulates deep linking logic,
- and anything else.

### Key features

- Provides all the infrastructure - you should only create your own mini-`AppDelegate` classes with single responsibilities.
- Has simple dependency injection system for injecting your mini-instances,
- Battle-tested into a lot of *Rambler&Co* projects.

### Installation

`pod RamblerAppDelegateProxy`

### Usage
Create a `RemoteNotificationAppDelegate` class which conforms to `UIApplicationDelegate` protocol.

```objc
@interface RemoteNotificationAppDelegate : NSObject <UIApplicationDelegate>

@end
...
@implementation RemoteNotificationAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSDictionary *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (notification) {
        NSLog(@"Launching from push %@", notification);
    }
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Did register for remote notifications");
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
   NSLog(@"Did receive remote notification");}
}

@end
```

Change the `main.m` file implementation:

```objc
int main(int argc, char * argv[]) {
    @autoreleasepool {
        [[RamblerAppDelegateProxy injector] addAppDelegates:@[[RemoteNotificationAppDelegate new]]];

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([RamblerAppDelegateProxy class]));
    }
}
```

Use your `RemoteNotificationAppDelegate` in the same way as the standart `AppDelegate` class - just remember to not mess its responsibilities.

### Authors

[Vadim Smal](https://github.com/CognitiveDisson)

### License

MIT
