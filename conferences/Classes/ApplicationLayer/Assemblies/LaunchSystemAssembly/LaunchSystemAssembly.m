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

#import "SpotlightAppDelegate.h"
#import "SpotlightLaunchHandler.h"
#import "EventLaunchRouter.h"
#import "SpeakerLaunchRouter.h"
#import "LectureLaunchRouter.h"

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

#pragma mark - Launch handlers

- (SpotlightLaunchHandler *)eventLaunchHandler {
    return [TyphoonDefinition withClass:[SpotlightLaunchHandler class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithObjectTransformer:dataCardLaunchRouter:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self.spotlightIndexerAssembly eventObjectTransformer]];
                                                  [initializer injectParameterWith:[self eventLaunchRouter]];
                                              }];
                          }];
}

- (SpotlightLaunchHandler *)speakerLaunchHandler {
    return [TyphoonDefinition withClass:[SpotlightLaunchHandler class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithObjectTransformer:dataCardLaunchRouter:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self.spotlightIndexerAssembly speakerObjectTransformer]];
                                                  [initializer injectParameterWith:[self speakerLaunchRouter]];
                                              }];
                          }];
}

- (SpotlightLaunchHandler *)lectureLaunchHandler {
    return [TyphoonDefinition withClass:[SpotlightLaunchHandler class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithObjectTransformer:dataCardLaunchRouter:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self.spotlightIndexerAssembly lectureObjectTransformer]];
                                                  [initializer injectParameterWith:[self lectureLaunchRouter]];
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

@end
