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

#import "LaunchSystemAssembly.h"

#import "ApplicationHelperAssembly.h"
#import "StoryboardAssembly.h"
#import "SystemInfrastructureAssembly.h"
#import "SpotlightIndexerAssembly.h"

#import "QuickActionAppDelegate.h"
#import "QuickActionUserActivityFactory.h"
#import "QuickActionLaunchHandler.h"
#import "SpotlightAppDelegate.h"
#import "SpotlightContinuationAppDelegate.h"
#import "SpotlightLaunchHandler.h"
#import "EventLaunchRouter.h"
#import "SpeakerLaunchRouter.h"
#import "LectureLaunchRouter.h"
#import "TabLaunchRouter.h"
#import "SearchLaunchRouter.h"

#import "QuickActionConstants.h"

static NSUInteger const kRamblerLocationTabIndex = 1;
static NSUInteger const kSearchTabIndex = 2;

@implementation LaunchSystemAssembly

#pragma mark - Public methods

- (SpotlightAppDelegate *)spotlightAppDelegate {
    return [TyphoonDefinition withClass:[SpotlightAppDelegate class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithLaunchHandlers:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:@[
                                                                                     [self eventLaunchHandler],
                                                                                     [self speakerLaunchHandler],
                                                                                     [self lectureLaunchHandler]
                                                                                     ]];
                                              }];
                              definition.scope = TyphoonScopeSingleton;
                          }];
}

- (SpotlightContinuationAppDelegate *)spotlightContinuationAppDelegate {
    return [TyphoonDefinition withClass:[SpotlightContinuationAppDelegate class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(router)
                                                    with:[self searchWithTextLaunchRouter]];
                              definition.scope = TyphoonScopeSingleton;
                          }];
}

- (QuickActionAppDelegate *)quickActionAppDelegate {
    return [TyphoonDefinition withClass:[QuickActionAppDelegate class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithLaunchHandlers:userActivityFactory:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:@[
                                                                                     [self eventQuickActionLaunchHandler],
                                                                                     [self ramblerLocationQuickActionLaunchHandler],
                                                                                     [self searchQuickActionLaunchHandler]
                                                                                     ]];
                                                  [initializer injectParameterWith:[self quickActionUserActivityFactory]];
                                              }];
                              definition.scope = TyphoonScopeSingleton;
                          }];
}

#pragma mark - Launch handlers

- (SpotlightLaunchHandler *)eventLaunchHandler {
    return [TyphoonDefinition withClass:[SpotlightLaunchHandler class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithObjectTransformer:launchRouter:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self.spotlightIndexerAssembly eventObjectTransformer]];
                                                  [initializer injectParameterWith:[self eventLaunchRouter]];
                                              }];
                          }];
}

- (SpotlightLaunchHandler *)speakerLaunchHandler {
    return [TyphoonDefinition withClass:[SpotlightLaunchHandler class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithObjectTransformer:launchRouter:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self.spotlightIndexerAssembly speakerObjectTransformer]];
                                                  [initializer injectParameterWith:[self speakerLaunchRouter]];
                                              }];
                          }];
}

- (SpotlightLaunchHandler *)lectureLaunchHandler {
    return [TyphoonDefinition withClass:[SpotlightLaunchHandler class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithObjectTransformer:launchRouter:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self.spotlightIndexerAssembly lectureObjectTransformer]];
                                                  [initializer injectParameterWith:[self lectureLaunchRouter]];
                                              }];
                          }];
}

- (QuickActionLaunchHandler *)eventQuickActionLaunchHandler {
    return [TyphoonDefinition withClass:[QuickActionLaunchHandler class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithObjectTransformer:launchRouter:quickActionItemType:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self.spotlightIndexerAssembly eventObjectTransformer]];
                                                  [initializer injectParameterWith:[self eventLaunchRouter]];
                                                  [initializer injectParameterWith:nil];
                                              }];
                          }];
}

- (QuickActionLaunchHandler *)ramblerLocationQuickActionLaunchHandler {
    return [TyphoonDefinition withClass:[QuickActionLaunchHandler class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithObjectTransformer:launchRouter:quickActionItemType:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:nil];
                                                  [initializer injectParameterWith:[self ramblerLocationLaunchRouter]];
                                                  [initializer injectParameterWith:kRamblerLocationQuickActionType];
                                              }];
                          }];
}

- (QuickActionLaunchHandler *)searchQuickActionLaunchHandler {
    return [TyphoonDefinition withClass:[QuickActionLaunchHandler class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithObjectTransformer:launchRouter:quickActionItemType:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:nil];
                                                  [initializer injectParameterWith:[self searchLaunchRouter]];
                                                  [initializer injectParameterWith:kSearchQuickActionType];
                                              }];
                          }];
}

#pragma mark - Launch routers

- (EventLaunchRouter *)eventLaunchRouter {
    return [TyphoonDefinition withClass:[EventLaunchRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithTabBarControllerFactory:window:storyboard:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self.applicationHelperAssembly tabBarControllerFactory]];
                                                  [initializer injectParameterWith:[self.systemInfrastructureAssembly mainWindow]];
                                                  [initializer injectParameterWith:[self.storyboardAssembly eventStoryboard]];
                                              }];
                          }];
}

- (SpeakerLaunchRouter *)speakerLaunchRouter {
    return [TyphoonDefinition withClass:[SpeakerLaunchRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithTabBarControllerFactory:window:storyboard:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self.applicationHelperAssembly tabBarControllerFactory]];
                                                  [initializer injectParameterWith:[self.systemInfrastructureAssembly mainWindow]];
                                                  [initializer injectParameterWith:[self.storyboardAssembly speakerStoryboard]];
                                              }];
                          }];
}

- (LectureLaunchRouter *)lectureLaunchRouter {
    return [TyphoonDefinition withClass:[LectureLaunchRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithTabBarControllerFactory:window:storyboard:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self.applicationHelperAssembly tabBarControllerFactory]];
                                                  [initializer injectParameterWith:[self.systemInfrastructureAssembly mainWindow]];
                                                  [initializer injectParameterWith:[self.storyboardAssembly lectureStoryboard]];
                                              }];
                          }];
}

- (TabLaunchRouter *)ramblerLocationLaunchRouter {
    return [TyphoonDefinition withClass:[TabLaunchRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithTabBarControllerFactory:window:tabIndex:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self.applicationHelperAssembly tabBarControllerFactory]];
                                                  [initializer injectParameterWith:[self.systemInfrastructureAssembly mainWindow]];
                                                  [initializer injectParameterWith:@(kRamblerLocationTabIndex)];
                                              }];
                          }];
}

- (TabLaunchRouter *)searchLaunchRouter {
    return [TyphoonDefinition withClass:[TabLaunchRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithTabBarControllerFactory:window:tabIndex:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self.applicationHelperAssembly tabBarControllerFactory]];
                                                  [initializer injectParameterWith:[self.systemInfrastructureAssembly mainWindow]];
                                                  [initializer injectParameterWith:@(kSearchTabIndex)];
                                              }];
                          }];
}

- (SearchLaunchRouter *)searchWithTextLaunchRouter {
    return [TyphoonDefinition withClass:[SearchLaunchRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithTabBarControllerFactory:window:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self.applicationHelperAssembly tabBarControllerFactory]];
                                                  [initializer injectParameterWith:[self.systemInfrastructureAssembly mainWindow]];
                                              }];
                          }];
}

#pragma mark - Factories

- (QuickActionUserActivityFactory *)quickActionUserActivityFactory {
    return [TyphoonDefinition withClass:[QuickActionUserActivityFactory class]];
}

@end
