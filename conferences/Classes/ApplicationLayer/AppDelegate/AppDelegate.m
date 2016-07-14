// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AppDelegate.h"

#import "ApplicationConfigurator.h"
#import "PushNotificationCenter.h"
#import "ThirdPartiesConfigurator.h"

#import <RamblerTyphoonUtils/AssemblyCollector.h>
#import <Typhoon/Typhoon.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self activateAssemblies];
    [self.thirdPartiesConfigurator configurate];
    [self.applicationConfigurator setupCoreDataStack];
    [self.pushNotificationCenter registerApplicationForPushNotificationsIfNeeded:application];
    
    NSDictionary *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (notification) {
        [self.pushNotificationCenter processPushNotificationWithUserInfo:notification
                                                        applicationState:application.applicationState];
    }
    
    return YES;
}

- (void)activateAssemblies {
    RamblerInitialAssemblyCollector *collector = [RamblerInitialAssemblyCollector new];
    NSMutableArray *classes = [[collector collectInitialAssemblyClasses] mutableCopy];
    NSMutableArray *assemblies = [NSMutableArray arrayWithCapacity:classes.count];
    TyphoonAssembly *assembly = [classes.firstObject new];
    [classes removeObjectAtIndex:0];
    
    for (Class assemblyClass in classes) {
        id assembly = [assemblyClass new];
        [assemblies addObject:assembly];
    }
    
    //В текущей реализации глобальные TyphoonConfig не работают
    TyphoonComponentFactory *factory = (TyphoonComponentFactory *)[assembly activateWithCollaboratingAssemblies:assemblies];
    [TyphoonComponentFactory setFactoryForResolvingUI:factory];
    [factory inject:self];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [self.pushNotificationCenter didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [self.pushNotificationCenter processPushNotificationWithUserInfo:userInfo
                                                    applicationState:application.applicationState];
}

@end
