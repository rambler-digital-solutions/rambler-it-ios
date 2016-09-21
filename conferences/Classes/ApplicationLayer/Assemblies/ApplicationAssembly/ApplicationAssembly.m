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

#import "ApplicationAssembly.h"

#import "SystemInfrastructureAssembly.h"
#import "ApplicationHelperAssembly.h"
#import "LaunchSystemAssembly.h"
#import "SpotlightIndexerAssembly.h"
#import "DaemonAssembly.h"

#import "ApplicationConfigurator.h"
#import "ApplicationConfiguratorImplementation.h"
#import "ThirdPartiesConfigurator.h"
#import "ThirdPartiesConfiguratorImplementation.h"
#import "CleanLaunchRouter.h"
#import "CleanLaunchAppDelegate.h"
#import "ServiceComponents.h"

#import <RamblerAppDelegateProxy/RamblerAppDelegateProxy.h>

@implementation ApplicationAssembly

- (RamblerAppDelegateProxy *)applicationDelegateProxy {
    return [TyphoonDefinition withClass:[RamblerAppDelegateProxy class]
                          configuration:^(TyphoonDefinition *definition){
                              [definition injectMethod:@selector(addAppDelegates:)
                                            parameters:^(TyphoonMethod *method) {
                                                [method injectParameterWith:@[
                                                                              [self cleanStartAppDelegate],
                                                                              [self.launchSystemAssembly spotlightAppDelegate],
                                                                              [self.launchSystemAssembly quickActionAppDelegate], [self.launchSystemAssembly spotlightContinuationAppDelegate]
                                                                              ]
                                                                              ];
                                            }];
                              definition.scope = TyphoonScopeSingleton;
                          }];
}

- (CleanLaunchAppDelegate *)cleanStartAppDelegate {
    return [TyphoonDefinition withClass:[CleanLaunchAppDelegate class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(applicationConfigurator)
                                                    with:[self applicationConfigurator]];
                              [definition injectProperty:@selector(thirdPartiesConfigurator)
                                                    with:[self thirdPartiesConfigurator]];
                              [definition injectProperty:@selector(cleanStartRouter)
                                                    with:[self cleanStartRouter]];
                              [definition injectProperty:@selector(indexerMonitor)
                                                    with:[self.spotlightIndexerAssembly indexerMonitor]];
                              [definition injectProperty:@selector(spotlightCoreDataStackCoordinator)
                                                    with:[self.spotlightIndexerAssembly spotlightCoreDataStackCoordinator]];
                              [definition injectProperty:@selector(quickActionDaemon)
                                                    with:[self.daemonAssembly quickActionDaemon]];
                              
                              definition.scope = TyphoonScopeSingleton;
                          }];
}

- (id <ApplicationConfigurator>)applicationConfigurator {
    return [TyphoonDefinition withClass:[ApplicationConfiguratorImplementation class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(eventService)
                                                    with:[self.serviceComponents eventService]];
                          }];
}

- (id <ThirdPartiesConfigurator>)thirdPartiesConfigurator {
    return [TyphoonDefinition withClass:[ThirdPartiesConfiguratorImplementation class]];
}

#pragma mark - StartUpSystem

- (CleanLaunchRouter *)cleanStartRouter {
    return [TyphoonDefinition withClass:[CleanLaunchRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithTabBarControllerFactory:window:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self.applicationHelperAssembly tabBarControllerFactory]];
                                                  [initializer injectParameterWith:[self.systemInfrastructureAssembly mainWindow]];
                                              }];
                          }];
}

@end
