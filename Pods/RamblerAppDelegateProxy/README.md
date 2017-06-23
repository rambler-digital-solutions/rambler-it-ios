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

### Troubleshooting

Based on the concept, the proxy forwards only the methods defined in the protocol UIApplicationDelegate. If you need a additional method that must be implemented in AppDelegate, you need to create a subclass and implement this method in this class.
```objc
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
```
This subclass should be set as a default.
```objc
[[RamblerAppDelegateProxy injector] setDefaultAppDelegate:[AppDelegate new]];
```
This is necessary for example if you are using Typhoon. For injection depending in AppDelegates need to write a definition for RamblerAppDelegateProxy.
```objc
@implementation ApplicationAssembly

- (RamblerAppDelegateProxy *)applicationDelegateProxy {
    return [TyphoonDefinition withClass:[RamblerAppDelegateProxy class]
                          configuration:^(TyphoonDefinition *definition) {
                                [definition injectMethod:@selector(addAppDelegates:)
                                              parameters:^(TyphoonMethod *method) {
                                                    NSArray *appDelegates = @[
                                                        [self remoteNotificationAppDelegate]
                                                    ];
                                                    [method injectParameterWith:appDelegates];
                                                }];
                          }];
}

- (id<UIApplicationDelegate>)remoteNotificationAppDelegate {
    return [TyphoonDefinition withClass:[RCMLaunchingAppDelegate class]
                          configuration:^(TyphoonDefinition *definition) {
                          }];
}

@end
```

### Authors

[Vadim Smal](https://github.com/CognitiveDisson)

### License

MIT
