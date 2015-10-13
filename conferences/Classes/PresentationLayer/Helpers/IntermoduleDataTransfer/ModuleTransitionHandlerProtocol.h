
#import <UIKit/UIKit.h>
#import <UIViewController+Routing/UIViewController+Routing.h>

@protocol ModuleConfigurationPromiseProtocol;

@protocol ModuleTransitionHandlerProtocol <NSObject>

@optional
- (id<ModuleConfigurationPromiseProtocol>)embedModuleWithSegue:(NSString*)segueIdentifier
                                                intoContainerView:(UIView*)containerView
                                                       withSender:(id)sender;
- (UIView*)containerViewWithIdentifier:(NSString*)identifier;
- (void)removeFromParentModule;


- (id<ModuleConfigurationPromiseProtocol>)performPromiseSegue:(NSString*)segueIdentifier withSender:(id)sender;


- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;
- (UINavigationController*)navigationController;

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender preparationBlock:(YDPreparationBlock)block;
- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)embedViewController:(UIViewController*)viewController;
- (void)removeViewControllersOfClass:(Class)viewControllerClass;

@end
