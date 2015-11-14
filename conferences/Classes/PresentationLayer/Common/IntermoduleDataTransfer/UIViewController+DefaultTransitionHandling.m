
#import "UIViewController+DefaultTransitionHandling.h"
#import "ModuleConfigurationPromise.h"
#import "ModuleConfiguratorHolder.h"

@implementation UIViewController (DefaultTransitionHandling)

- (id<ModuleConfigurationPromiseProtocol>)default_performPromiseSegue:(NSString*)segueIdentifier withSender:(id)sender {
    ModuleConfigurationPromise *promise = [[ModuleConfigurationPromise alloc] init];
    [self performSegueWithIdentifier:segueIdentifier sender:@{
                                                              @"sender":sender,
                                                              @"promise":promise
                                                              }];
    return promise;
}

- (void)default_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[NSDictionary class]] && [segue.destinationViewController conformsToProtocol:@protocol(ModuleConfiguratorHolder)]) {
        ModuleConfigurationPromise * promise = sender[@"promise"];
        [promise setModuleConfigurator:[(id<ModuleConfiguratorHolder>)segue.destinationViewController moduleConfigurator]];
    }
}

- (void)default_embedViewController:(UIViewController*)viewController {
    [self addChildViewController:viewController];
    [viewController.view setFrame: self.view.bounds];
    [self.view addSubview: viewController.view];    
}

@end
