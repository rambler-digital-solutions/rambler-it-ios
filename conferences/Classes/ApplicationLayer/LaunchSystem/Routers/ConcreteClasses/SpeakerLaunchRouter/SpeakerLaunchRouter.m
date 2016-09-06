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

#import "SpeakerLaunchRouter.h"

#import "SpeakerModelObject.h"
#import "TabBarControllerFactory.h"
#import "SpeakerInfoModuleInput.h"

#import <UIKit/UIKit.h>
#import <ViperMcFlurry/ViperMcFlurry.h>

static NSString *const kSpeakerControllerIdentifier = @"SpeakerInfoViewController";

@interface SpeakerLaunchRouter ()

@property (nonatomic, strong) id<TabBarControllerFactory> tabBarControllerFactory;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIStoryboard *storyboard;

@end

@implementation SpeakerLaunchRouter

#pragma mark - Initialization

- (instancetype)initWithTabBarControllerFactory:(id<TabBarControllerFactory>)tabBarControllerFactory
                                         window:(UIWindow *)window
                                     storyboard:(UIStoryboard *)storyboard {
    self = [super init];
    if (self) {
        _tabBarControllerFactory = tabBarControllerFactory;
        _window = window;
        _storyboard = storyboard;
    }
    return self;
}

#pragma mark - <LaunchRouter>

- (void)openScreenWithData:(SpeakerModelObject *)data {
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    if (!tabBarController) {
        tabBarController = [self.tabBarControllerFactory obtainPreconfiguredTabBarController];
    }
    
    RamblerViperModuleFactory *factory = [[RamblerViperModuleFactory alloc] initWithStoryboard:self.storyboard
                                                                              andRestorationId:kSpeakerControllerIdentifier];
    
    ModuleTransitionBlock transitionBlock = [self speakerTransitionBlock];
    RamblerViperModuleLinkBlock configurationBlock = [self speakerConfigurationBlockWithSpeakerId:data.speakerId];
    
    UINavigationController *navigationController = [tabBarController selectedViewController];
    [[navigationController.topViewController openModuleUsingFactory:factory
                                                withTransitionBlock:transitionBlock]
     thenChainUsingBlock:configurationBlock];
    
    if (!self.window.rootViewController) {
        self.window.rootViewController = tabBarController;
        [self.window makeKeyAndVisible];
    }
}

#pragma mark - Private methods

- (ModuleTransitionBlock)speakerTransitionBlock {
    return ^(id<RamblerViperModuleTransitionHandlerProtocol> sourceModuleTransitionHandler, id<RamblerViperModuleTransitionHandlerProtocol> destinationModuleTransitionHandler) {
        UIViewController *destinationViewController = (id)destinationModuleTransitionHandler;
        UINavigationController *navigationController = [(id)sourceModuleTransitionHandler navigationController];
        [navigationController pushViewController:destinationViewController
                                        animated:NO];
    };
}

- (RamblerViperModuleLinkBlock)speakerConfigurationBlockWithSpeakerId:(NSString *)speakerId {
    return ^id<RamblerViperModuleOutput>(id<SpeakerInfoModuleInput> moduleInput) {
        [moduleInput configureCurrentModuleWithSpeakerId:speakerId];
        return nil;
    };
}

@end
